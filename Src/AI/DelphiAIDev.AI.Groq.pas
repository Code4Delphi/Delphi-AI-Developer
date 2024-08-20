unit DelphiAIDev.AI.Groq;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Classes,
  RESTRequest4D,
  DelphiAIDev.Utils,
  DelphiAIDev.Settings,
  DelphiAIDev.AI.Interfaces;

type
  TDelphiAIDevAIGroq = class(TInterfacedObject, IDelphiAIDevAI)
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
  API_JSON_BODY_BASE = '{"messages": [{"role": "user", "content": "%s"}], "model": "%s"}';

class function TDelphiAIDevAIGroq.New(const ASettings: TDelphiAIDevSettings): IDelphiAIDevAI;
begin
  Result := Self.Create(ASettings);
end;

constructor TDelphiAIDevAIGroq.Create(const ASettings: TDelphiAIDevSettings);
begin
  FSettings := ASettings;
end;

function TDelphiAIDevAIGroq.GetResponse(const AQuestion: string): string;
var
  LResponse: IResponse;
  LJsonValueAll: TJSONVALUE;
  LJsonArrayChoices: TJsonArray;
  LJsonObjMessage: TJsonObject;
  LContent: string;
  LItemChoices: Integer;
begin
  Result := '';

  LResponse := TRequest.New
    .BaseURL(FSettings.BaseUrlGroq)
    .ContentType('application/json')
    .Accept('application/json')
    .Token('Bearer ' + FSettings.ApiKeyGroq)
    .AddBody(Format(API_JSON_BODY_BASE, [AQuestion, FSettings.ModelGroq]))
    .Post;

  if LResponse.StatusCode <> 200 then
    Exit('Question cannot be answered' + sLineBreak + 'Return: ' + LResponse.Content);

  LJsonValueAll := TJsonObject.ParseJSONValue(LResponse.Content);
  if not(LJsonValueAll is TJSONObject) then
    Exit('The question cannot be answered, return object not found.' + sLineBreak +
      'Return: ' + LResponse.Content);

  LJsonArrayChoices := (LJsonValueAll as TJsonObject).GetValue<TJsonArray>('choices');
  for LItemChoices := 0 to Pred(LJsonArrayChoices.Count) do
  begin
    LJsonObjMessage := LJsonArrayChoices.Items[LItemChoices].GetValue<TJsonObject>('message');
    LContent := LJsonObjMessage.GetValue<string>('content');
    Result := Result + LContent.Trim + sLineBreak;
  end;

  Result := Result.Trim;
end;

end.
