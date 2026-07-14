unit DelphiAIDev.AI.Gemini;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Classes,
  RESTRequest4D,
  DelphiAIDev.Consts,
  DelphiAIDev.Utils,
  DelphiAIDev.Settings,
  DelphiAIDev.AI.Interfaces,
  DelphiAIDev.AI.Response;

type
  TDelphiAIDevAIGemini = class(TInterfacedObject, IDelphiAIDevAI)
  private
    FSettings: TDelphiAIDevSettings;
    FResponse: IDelphiAIDevAIResponse;
    function GetApiUrl: string;
  protected
    function GetResponse(const AQuestion: string): IDelphiAIDevAIResponse;
  public
    constructor Create(const ASettings: TDelphiAIDevSettings; const AResponse: IDelphiAIDevAIResponse);
  end;

implementation

const
  API_JSON_BODY_BASE = '{"contents": [{"parts": [ {"text": "%s"}]}]}';

constructor TDelphiAIDevAIGemini.Create(const ASettings: TDelphiAIDevSettings; const AResponse: IDelphiAIDevAIResponse);
begin
  FSettings := ASettings;
  FResponse := AResponse;
end;

function TDelphiAIDevAIGemini.GetApiUrl: string;
  begin
    var LBaseUrl := FSettings.BaseUrlGemini.Trim;
    if not LBaseUrl.EndsWith('/') then
      LBaseUrl := LBaseUrl + '/';

    var LModel := FSettings.ModelGemini.Trim;
    var LModelLower := LModel.ToLower;
    if LModelLower.StartsWith('http://') or LModelLower.StartsWith('https://') then
      Exit(LModel);

    if LModelLower.StartsWith('v1/') or LModelLower.StartsWith('v1beta/') then
      Exit(LBaseUrl + LModel);

    if LModelLower.StartsWith('models/') then
      Exit(LBaseUrl + 'v1beta/' + LModel);

    if not LModelLower.EndsWith(':generatecontent') then
      LModel := LModel + ':generateContent';

    var LBaseUrlLower := LBaseUrl.ToLower;
    if LBaseUrlLower.EndsWith('/v1/models/') or LBaseUrlLower.EndsWith('/v1beta/models/') then
      Exit(LBaseUrl + LModel);

    if LBaseUrlLower.EndsWith('/v1/') or LBaseUrlLower.EndsWith('/v1beta/') then
      Exit(LBaseUrl + 'models/' + LModel);

    Result := LBaseUrl + 'v1beta/models/' + LModel;
  end;

function TDelphiAIDevAIGemini.GetResponse(const AQuestion: string): IDelphiAIDevAIResponse;
var
  LResponse: IResponse;
  LJsonValueAll: TJSONVALUE;
  LJsonArrayCandidates: TJsonArray;
  LJsonArrayParts: TJsonArray;
  LJsonObjContent: TJsonObject;
  LJsonObjParts: TJsonObject;
  LItemCandidates: Integer;
  LItemParts: Integer;
  LResult: string;
begin
  Result := FResponse;

  LResponse := TRequest.New
    .BaseURL(Self.GetApiUrl)
    .ContentType(TConsts.APPLICATION_JSON)
    .Accept(TConsts.APPLICATION_JSON)
    .AddHeader('x-goog-api-key', FSettings.ApiKeyGemini)
    .AddBody(Format(API_JSON_BODY_BASE, [AQuestion]))
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

  LJsonArrayCandidates := (LJsonValueAll as TJsonObject).GetValue<TJsonArray>('candidates');
  for LItemCandidates := 0 to Pred(LJsonArrayCandidates.Count) do
  begin
    LJsonObjContent := LJsonArrayCandidates.Items[LItemCandidates].GetValue<TJsonObject>('content');
    LJsonArrayParts := LJsonObjContent.GetValue<TJsonArray>('parts');
    for LItemParts := 0 to Pred(LJsonArrayParts.Count) do
    begin
      LJsonObjParts := LJsonArrayParts.Items[LItemParts] as TJsonObject;
      LResult := LResult + LJsonObjParts.GetValue<string>('text').Trim + sLineBreak;
    end;
  end;

  FResponse.SetContentText(LResult.Trim);
end;

end.
