unit DelphiCopilot.AI.Gemini;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Classes,
  RESTRequest4D,
  DelphiCopilot.Utils,
  DelphiCopilot.Settings,
  DelphiCopilot.AI.Interfaces;

type
  TDelphiCopilotAIGemini = class(TInterfacedObject, IDelphiCopilotAI)
  private
    FSettings: TDelphiCopilotSettings;
  protected
    function GetResponse(const AQuestion: string): string;
  public
    class function New(const ASettings: TDelphiCopilotSettings): IDelphiCopilotAI;
    constructor Create(const ASettings: TDelphiCopilotSettings);
  end;

implementation

const
  API_JSON_BODY_BASE = '{"contents": [{"parts": [ {"text": "%s"}]}]}';

class function TDelphiCopilotAIGemini.New(const ASettings: TDelphiCopilotSettings): IDelphiCopilotAI;
begin
  Result := Self.Create(ASettings);
end;

constructor TDelphiCopilotAIGemini.Create(const ASettings: TDelphiCopilotSettings);
begin
  FSettings := ASettings;
end;

function TDelphiCopilotAIGemini.GetResponse(const AQuestion: string): string;
var
  LApiUrl: string;
  LResponse: IResponse;
  LJsonValue: TJSONVALUE;
  LJsonArray: TJsonArray;
  LPartsArray: TJsonArray;
  LJsonObj: TJsonObject;
  LPartsObj: TJsonObject;
  LJsonText: string;
  i, j: Integer;
begin
  Result := '';
  LApiUrl := FSettings.BaseUrlGemini + FSettings.ModelGemini + '?key=' + FSettings.ApiKeyGemini;

  LResponse := TRequest.New
    .BaseURL(LApiUrl)
    .Accept('application/json')
    .AddBody(Format(API_JSON_BODY_BASE, [AQuestion.Trim]))
    .Post;

  if LResponse.StatusCode <> 200 then
  begin
    Result := 'Question cannot be answered' + sLineBreak +
      'Return: ' + LResponse.Content;
    Exit;
  end;

  LJsonValue := TJsonObject.ParseJSONValue(LResponse.Content);
  if LJsonValue is TJsonObject then
  begin
    LJsonArray := (LJsonValue as TJsonObject).GetValue<TJsonArray>('candidates');
    for i := 0 to Pred(LJsonArray.Count) do
    begin
      LJsonObj := LJsonArray.Items[i].GetValue<TJsonObject>('content');
      LPartsArray := LJsonObj.GetValue<TJsonArray>('parts');
      for j := 0 to Pred(LPartsArray.Count) do
      begin
        LPartsObj := LPartsArray.Items[j] as TJsonObject;
        LJsonText := LPartsObj.GetValue<string>('text');
        Result := LJsonText.Trim;
      end;
    end;
  end;
end;

end.
