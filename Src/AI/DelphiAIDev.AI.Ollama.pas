unit DelphiAIDev.AI.Ollama;

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
  TDelphiAIDevAIOllama = class(TInterfacedObject, IDelphiAIDevAI)
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
  API_JSON_BODY_BASE = //'{"messages": [{"role": "user", "content": "%s"}], "model": "%s"}';
    '{"model": "%s", '+
    '"messages": [{"role": "user", "content": "%s"}], '+
    '"stream": false}';

class function TDelphiAIDevAIOllama.New(const ASettings: TDelphiAIDevSettings): IDelphiAIDevAI;
begin
  Result := Self.Create(ASettings);
end;

constructor TDelphiAIDevAIOllama.Create(const ASettings: TDelphiAIDevSettings);
begin
  FSettings := ASettings;
end;

function TDelphiAIDevAIOllama.GetResponse(const AQuestion: string): string;
var
  LResponse: IResponse;
  LJsonValueAll: TJSONVALUE;
  LJsonValueMessage: TJSONValue;
  LJsonObjMessage: TJsonObject;
begin
  Result := '';

  LResponse := TRequest.New
    .BaseURL(FSettings.BaseUrlOllama)
    .ContentType(TConsts.APPLICATION_JSON)
    .Accept(TConsts.APPLICATION_JSON)
    //.Token('Bearer ' + FSettings.ApiKeyOllama)
    .AddBody(Format(API_JSON_BODY_BASE, [FSettings.ModelOllama, AQuestion]))
    .Post;

  if LResponse.StatusCode <> 200 then
    Exit('Question cannot be answered' + sLineBreak + 'Return: ' + LResponse.Content);

  LJsonValueAll := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LResponse.Content), 0);
  if not(LJsonValueAll is TJSONObject) then
    Exit('The question cannot be answered, return object not found.' + sLineBreak +
      'Return: ' + LResponse.Content);

  LJsonValueMessage := (LJsonValueAll as TJSONObject).GetValue('message');
  if not(LJsonValueMessage is TJSONObject) then
    Exit('The question cannot be answered, return object not found.' + sLineBreak +
      'Return: ' + LResponse.Content);

  LJsonObjMessage := LJsonValueMessage as TJSONObject;
  Result := TJSONString(LJsonObjMessage.GetValue('content')).Value.Trim;
end;

end.
