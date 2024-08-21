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
  protected
    function GetResponse(const AQuestion: string): string;
  public
    class function New(const ASettings: TDelphiAIDevSettings): IDelphiAIDevAI;
    constructor Create(const ASettings: TDelphiAIDevSettings);
  end;

implementation

const
  API_JSON_BODY_BASE = '{"model": "%s", "messages": [{"role": "user", "content": "%s"}], "stream": false, "max_tokens": 2048}';

class function TDelphiAIDevAIChatGPT.New(const ASettings: TDelphiAIDevSettings): IDelphiAIDevAI;
begin
  Result := Self.Create(ASettings);
end;

constructor TDelphiAIDevAIChatGPT.Create(const ASettings: TDelphiAIDevSettings);
begin
  FSettings := ASettings;
end;

function TDelphiAIDevAIChatGPT.GetResponse(const AQuestion: string): string;
var
  LResponse: IResponse;
  LJsonValueAll: TJSONValue;
  LJsonValueChoices: TJSONValue;
  LJsonArrayChoices: TJSONArray;
  LJsonObjChoices: TJSONObject;
  LJsonValueMessage: TJSONValue;
  LJsonObjMessage: TJSONObject;
  LItemChoices: Integer;
begin
  Result := '';

  LResponse := TRequest.New
    .BaseURL(FSettings.BaseUrlOpenAI)
    .ContentType(TConsts.APPLICATION_JSON)
    .Accept(TConsts.APPLICATION_JSON)
    .Token('Bearer ' + FSettings.ApiKeyOpenAI)
    .AddBody(Format(API_JSON_BODY_BASE, [FSettings.ModelOpenAI, AQuestion]))
    .Post;

  if LResponse.StatusCode <> 200 then
    Exit('Question cannot be answered' + sLineBreak + 'Return: ' + LResponse.Content);

  LJsonValueAll := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LResponse.Content), 0);
  if not(LJsonValueAll is TJSONObject) then
    Exit('The question cannot be answered, return object not found.' + sLineBreak +
      'Return: ' + LResponse.Content);

  LJsonValueChoices := TJSONObject(LJsonValueAll).GetValue('choices');
  if not(LJsonValueChoices is TJSONArray) then
    Exit('The question cannot be answered, choices not found.' + sLineBreak +
      'Return: ' + LResponse.Content);

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
    Result := Result + TJSONString(LJsonObjMessage.GetValue('content')).Value.Trim + sLineBreak;
  end;

  Result := Result.Trim;
end;

end.
