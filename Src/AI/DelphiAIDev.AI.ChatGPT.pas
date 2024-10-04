unit DelphiAIDev.AI.ChatGPT;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Classes,
  RESTRequest4D,
  DelphiAIDev.Consts,
  DelphiAIDev.Utils,
  DelphiAIDev.Settings,
  DelphiAIDev.AI.Interfaces;

type
  TDelphiAIDevAIChatGPT = class(TInterfacedObject, IDelphiAIDevAI)
  private
    FSettings: TDelphiAIDevSettings;
    FResponse: IDelphiAIDevAIResponse;
  protected
    function GetResponse(const AQuestion: string): IDelphiAIDevAIResponse;
  public
    constructor Create(const ASettings: TDelphiAIDevSettings; const AResponse: IDelphiAIDevAIResponse);
  end;

implementation

const
  API_JSON_BODY_BASE = '{"model": "%s", "messages": [{"role": "user", "content": "%s"}], "stream": false, "max_tokens": 2048}';

constructor TDelphiAIDevAIChatGPT.Create(const ASettings: TDelphiAIDevSettings; const AResponse: IDelphiAIDevAIResponse);
begin
  FSettings := ASettings;
  FResponse := AResponse;
end;

function TDelphiAIDevAIChatGPT.GetResponse(const AQuestion: string): IDelphiAIDevAIResponse;
var
  LResponse: IResponse;
  LJsonValueAll: TJSONValue;
  LJsonValueChoices: TJSONValue;
  LJsonArrayChoices: TJSONArray;
  LJsonObjChoices: TJSONObject;
  LJsonValueMessage: TJSONValue;
  LJsonObjMessage: TJSONObject;
  LItemChoices: Integer;
  LResult: string;
begin
  Result := FResponse;

  LResponse := TRequest.New
    .BaseURL(FSettings.BaseUrlOpenAI)
    .ContentType(TConsts.APPLICATION_JSON)
    .Accept(TConsts.APPLICATION_JSON)
    .Token('Bearer ' + FSettings.ApiKeyOpenAI)
    .AddBody(Format(API_JSON_BODY_BASE, [FSettings.ModelOpenAI, AQuestion]))
    .Post;

  FResponse.SetStatusCode(LResponse.StatusCode);

  if LResponse.StatusCode <> 200 then
  begin
    FResponse.SetContentText('Question cannot be answered' + sLineBreak + 'Return: ' + LResponse.Content);
    Exit;
  end;

  LJsonValueAll := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LResponse.Content), 0);
  if not(LJsonValueAll is TJSONObject) then
  begin
    FResponse.SetContentText('The question cannot be answered, return object not found.' + sLineBreak +
      'Return: ' + LResponse.Content);
    Exit;
  end;

  LJsonValueChoices := TJSONObject(LJsonValueAll).GetValue('choices');
  if not(LJsonValueChoices is TJSONArray) then
  begin
    FResponse.SetContentText('The question cannot be answered, choices not found.' + sLineBreak +
      'Return: ' + LResponse.Content);
    Exit;
  end;

  LJsonArrayChoices := LJsonValueChoices as TJSONArray;
  for LItemChoices := 0 to Pred(LJsonArrayChoices.Count) do
  begin
    if not(LJsonArrayChoices.Items[LItemChoices] is TJSONObject) then
      Continue;

    //CAST ITEM CHOICES LIKE TJSONObject
    LJsonObjChoices := LJsonArrayChoices.Items[LItemChoices] as TJSONObject;

    //GET MESSAGE LIKE TJSONValue
    LJsonValueMessage := LJsonObjChoices.GetValue('message');
    if not(LJsonValueMessage is TJSONObject) then
      Continue;

    //GET MESSAGE LIKE TJSONObject
    LJsonObjMessage := LJsonValueMessage as TJSONObject;
    LResult := LResult + TJSONString(LJsonObjMessage.GetValue('content')).Value.Trim + sLineBreak;
  end;

  FResponse.SetContentText(LResult.Trim);
end;

end.
