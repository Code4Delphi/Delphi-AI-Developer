unit DelphiAIDev.AI.Groq;

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
  TDelphiAIDevAIGroq = class(TInterfacedObject, IDelphiAIDevAI)
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
  API_JSON_BODY_BASE = '{"messages": [{"role": "user", "content": "%s"}], "model": "%s"}';

constructor TDelphiAIDevAIGroq.Create(const ASettings: TDelphiAIDevSettings; const AResponse: IDelphiAIDevAIResponse);
begin
  FSettings := ASettings;
  FResponse := AResponse;
end;

function TDelphiAIDevAIGroq.GetResponse(const AQuestion: string): IDelphiAIDevAIResponse;
var
  LResponse: IResponse;
  LJsonValueAll: TJSONVALUE;
  LJsonArrayChoices: TJsonArray;
  LJsonObjMessage: TJsonObject;
  LContent: string;
  LItemChoices: Integer;
  LResult: string;
begin
  Result := FResponse;

  LResponse := TRequest.New
    .BaseURL(FSettings.BaseUrlGroq)
    .ContentType(TConsts.APPLICATION_JSON)
    .Accept(TConsts.APPLICATION_JSON)
    .Token('Bearer ' + FSettings.ApiKeyGroq)
    .AddBody(Format(API_JSON_BODY_BASE, [AQuestion, FSettings.ModelGroq]))
    .Post;

  FResponse.SetStatusCode(LResponse.StatusCode);

  if LResponse.StatusCode <> 200 then
  begin
    FResponse.SetContentText('Question cannot be answered' + sLineBreak + 'Return: ' + LResponse.Content);
    Exit;
  end;

  LJsonValueAll := TJsonObject.ParseJSONValue(LResponse.Content);
  if not(LJsonValueAll is TJSONObject) then
  begin
    FResponse.SetContentText('The question cannot be answered, return object not found.' + sLineBreak +
      'Return: ' + LResponse.Content);
    Exit;
  end;

  LJsonArrayChoices := (LJsonValueAll as TJsonObject).GetValue<TJsonArray>('choices');
  for LItemChoices := 0 to Pred(LJsonArrayChoices.Count) do
  begin
    LJsonObjMessage := LJsonArrayChoices.Items[LItemChoices].GetValue<TJsonObject>('message');
    LContent := LJsonObjMessage.GetValue<string>('content');
    LResult := LResult + LContent.Trim + sLineBreak;
  end;

  FResponse.SetContentText(LResult.Trim);
end;

end.
