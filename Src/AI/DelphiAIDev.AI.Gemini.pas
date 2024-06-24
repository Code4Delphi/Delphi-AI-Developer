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
  LQuestion := TUtils.AdjustQuestionToJson(AQuestion);

  LResponse := TRequest.New
    .BaseURL(LApiUrl)
    .Accept('application/json')
    .AddBody(Format(API_JSON_BODY_BASE, [LQuestion]))
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
