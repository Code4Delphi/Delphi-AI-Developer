unit DelphiCopilot.AI.ChatGPT;

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
  TDelphiCopilotAIChatGPT = class(TInterfacedObject, IDelphiCopilotAI)
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
  API_JSON_BODY_BASE = '{"model": "%s", "messages": [{"role": "user", "content": "%s"}], "stream": false, "max_tokens": 2048}';

class function TDelphiCopilotAIChatGPT.New(const ASettings: TDelphiCopilotSettings): IDelphiCopilotAI;
begin
  Result := Self.Create(ASettings);
end;

constructor TDelphiCopilotAIChatGPT.Create(const ASettings: TDelphiCopilotSettings);
begin
  FSettings := ASettings;
end;

function TDelphiCopilotAIChatGPT.GetResponse(const AQuestion: string): string;
var
  LQuestion: string;
  LApiUrl: string;
  LResponse: IResponse;
  LReturnValue: TJSONValue;
  LChoicesValue: TJSONValue;
  LChoicesArray: TJSONArray;
  LChoicesObj: TJSONObject;
  LMessageValue: TJSONValue;
  LMessageObj: TJSONObject;
  I: Integer;
begin
  Result := '';
  LApiUrl := FSettings.BaseUrlOpenAI;
  LQuestion := AQuestion.Replace(sLineBreak, '\n', [rfReplaceAll, rfIgnoreCase]);

  LResponse := TRequest.New
    .BaseURL(LApiUrl)
    .ContentType('application/json')
    .Accept('application/json')
    .Token('Bearer ' + FSettings.ApiKeyOpenAI)
    .AddBody(Format(API_JSON_BODY_BASE, [FSettings.ModelOpenAI, LQuestion.Trim]))
    .Post;

  if LResponse.StatusCode <> 200 then
    Exit('Question cannot be answered' + sLineBreak + 'Return: ' + LResponse.Content);

  //TJSONValue COMPLETE
  LReturnValue := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LResponse.Content), 0);
  if not(LReturnValue is TJSONObject) then
    Exit('The question cannot be answered, return object not found.' + sLineBreak +
      'Return: ' + LResponse.Content);

  //GET CHOICES LIKE TJSONValue
  LChoicesValue := TJSONObject(LReturnValue).GetValue('choices');

  if not(LChoicesValue is TJSONArray) then
    Exit('The question cannot be answered, choices not found.' + sLineBreak +
      'Return: ' + LResponse.Content);

  //CAST CHOICES LIKE TJSONArray
  LChoicesArray := LChoicesValue as TJSONArray;
  for I := 0 to Pred(LChoicesArray.Count) do
  begin
    if not(LChoicesArray.Items[I] is TJSONObject) then
      Continue;

    //CAST ITEM CHOICES LIKE TJSONObject
    LChoicesObj := LChoicesArray.Items[I] as TJSONObject;

    //GET MESSAGE LIKE TJSONValue
    LMessageValue := LChoicesObj.GetValue('message');
    if not(LMessageValue is TJSONObject) then
      Continue;

    //GET MESSAGE LIKE TJSONObject
    LMessageObj := LMessageValue as TJSONObject;
    Result := Result + TJSONString(LMessageObj.GetValue('content')).Value + sLineBreak;
  end;

  Result := Result.Trim;
end;

end.
