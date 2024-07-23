unit DelphiAIDev.AI.Gemini;

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
  TDelphiAIDevAIGemini = class(TInterfacedObject, IDelphiAIDevAI)
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
  API_JSON_BODY_BASE = '{"contents": [{"parts": [ {"text": "%s"}]}]}';

class function TDelphiAIDevAIGemini.New(const ASettings: TDelphiAIDevSettings): IDelphiAIDevAI;
begin
  Result := Self.Create(ASettings);
end;

constructor TDelphiAIDevAIGemini.Create(const ASettings: TDelphiAIDevSettings);
begin
  FSettings := ASettings;
end;

function TDelphiAIDevAIGemini.GetResponse(const AQuestion: string): string;
var
  LApiUrl: string;
  LQuestion: string;
  LResponse: IResponse;
  LJsonValueAll: TJSONVALUE;
  LJsonArrayCandidates: TJsonArray;
  LJsonArrayParts: TJsonArray;
  LJsonObjContent: TJsonObject;
  LJsonObjParts: TJsonObject;
  LItemCandidates, LItemParts: Integer;
begin
  Result := '';
  LApiUrl := FSettings.BaseUrlGemini + FSettings.ModelGemini + '?key=' + FSettings.ApiKeyGemini;
  LQuestion := TUtils.AdjustQuestionToJson(AQuestion);

  LResponse := TRequest.New
    .BaseURL(LApiUrl)
    .Accept('application/json')
    .AddBody(Format(API_JSON_BODY_BASE, [LQuestion]))
    .Post;

  if LResponse.StatusCode <> 200 then
    Exit('Question cannot be answered' + sLineBreak + 'Return: ' + LResponse.Content);

  LJsonValueAll := TJsonObject.ParseJSONValue(LResponse.Content);
  if not(LJsonValueAll is TJSONObject) then
    Exit('The question cannot be answered, return object not found.' + sLineBreak +
      'Return: ' + LResponse.Content);

  LJsonArrayCandidates := (LJsonValueAll as TJsonObject).GetValue<TJsonArray>('candidates');
  for LItemCandidates := 0 to Pred(LJsonArrayCandidates.Count) do
  begin
    LJsonObjContent := LJsonArrayCandidates.Items[LItemCandidates].GetValue<TJsonObject>('content');
    LJsonArrayParts := LJsonObjContent.GetValue<TJsonArray>('parts');
    for LItemParts := 0 to Pred(LJsonArrayParts.Count) do
    begin
      LJsonObjParts := LJsonArrayParts.Items[LItemParts] as TJsonObject;
      Result := Result + LJsonObjParts.GetValue<string>('text').Trim + sLineBreak;
    end;
  end;

  Result := Result.Trim;
end;

end.
