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
    FResponse: IDelphiAIDevAIResponse;
  protected
    function GetResponse(const AQuestion: string): IDelphiAIDevAIResponse;
  public
    constructor Create(const ASettings: TDelphiAIDevSettings; const AResponse: IDelphiAIDevAIResponse);
  end;

implementation

const
  API_JSON_BODY_BASE =
    '{"model": "%s", '+
    '"messages": [{"role": "user", "content": "%s"}], '+
    '"options": {"seed": 101, "temperature": 0}, '+
    '"stream": false}';

constructor TDelphiAIDevAIOllama.Create(const ASettings: TDelphiAIDevSettings; const AResponse: IDelphiAIDevAIResponse);
begin
  FSettings := ASettings;
  FResponse := AResponse;
end;

function TDelphiAIDevAIOllama.GetResponse(const AQuestion: string): IDelphiAIDevAIResponse;
var
  LResponse: IResponse;
  LJsonValueAll: TJSONVALUE;
  LJsonValueMessage: TJSONValue;
  LJsonObjMessage: TJsonObject;
begin
  Result := FResponse;

  try
    LResponse := TRequest.New
      .BaseURL(FSettings.BaseUrlOllama)
      .ContentType(TConsts.APPLICATION_JSON)
      .Accept(TConsts.APPLICATION_JSON)
      //.Token('Bearer ' + FSettings.ApiKeyOllama)
      .AddBody(Format(API_JSON_BODY_BASE, [FSettings.ModelOllama, AQuestion]))
      .Post;
  except
    on E: Exception do
    begin
      FResponse.SetStatusCode(LResponse.StatusCode)
        .SetContentText('The question cannot be answered, return object not found.' + sLineBreak +
          'Return: ' + LResponse.Content);
      Exit;
    end;
  end;

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

  LJsonValueMessage := (LJsonValueAll as TJSONObject).GetValue('message');
  if not(LJsonValueMessage is TJSONObject) then
  begin
    FResponse.SetContentText('The question cannot be answered, return object not found.' + sLineBreak +
      'Return: ' + LResponse.Content);
    Exit;
  end;

  LJsonObjMessage := LJsonValueMessage as TJSONObject;
  FResponse.SetContentText(TJSONString(LJsonObjMessage.GetValue('content')).Value.Trim);
end;

end.
