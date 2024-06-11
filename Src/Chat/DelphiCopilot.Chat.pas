unit DelphiCopilot.Chat;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Classes,
  RESTRequest4D;

type
  TDelphiCopilotChat = class
  private
    FResponse: TStrings;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ProcessSend(const AQuestion: string);
    function Response: TStrings;
  end;

implementation

constructor TDelphiCopilotChat.Create;
begin
  FResponse := TStringList.Create;
end;

destructor TDelphiCopilotChat.Destroy;
begin
  FResponse.Free;
  inherited;
end;

procedure TDelphiCopilotChat.ProcessSend(const AQuestion: string);
const
  //API_URL = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=%s';
  API_URL = 'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=%s';
  API_KEY = 'AIzaSyArzMx-zCQPdBt9FT7hkWThwPTw2Hco6tM';
  API_JSON_BODY_BASE = '{"contents": [{"parts": [ {"text": "%s"}]}]}';
var
  LResponse: IResponse;

  JsonValue: TJSONVALUE;
  JsonArray, PartsArray: TJsonArray;
  JsonObj, PartsObj: TJsonObject;
  JsonText: String;
  i, j: Integer;
begin
  FResponse.Clear;

  LResponse := TRequest.New
    .BaseURL(Format(API_URL, [API_KEY]))
    .Accept('application/json')
    .AddBody(Format(API_JSON_BODY_BASE, [AQuestion]))
    .Post;

  if LResponse.StatusCode <> 200 then
  begin
    FResponse.Add('Question cannot be answered');
    FResponse.Add('Return: ' + LResponse.Content);
    Exit;
  end;

  JsonValue := TJsonObject.ParseJSONValue(LResponse.Content);
  if JsonValue is TJsonObject then
  begin
    JsonArray := (JsonValue as TJsonObject).GetValue<TJsonArray>('candidates');
    for i := 0 to JsonArray.Count - 1 do
    begin
      JsonObj := JsonArray.Items[i].GetValue<TJsonObject>('content');
      PartsArray := JsonObj.GetValue<TJsonArray>('parts');
      for j := 0 to PartsArray.Count - 1 do
      begin
        PartsObj := PartsArray.Items[j] as TJsonObject;
        JsonText := PartsObj.GetValue<string>('text');
        //FResponse.Add(TDelphiCopilotUtils.ConfReturnAI(JsonText));
        FResponse.Text := JsonText;
      end;
    end;
  end;
end;

function TDelphiCopilotChat.Response: TStrings;
begin
  Result := FResponse;
end;

end.
