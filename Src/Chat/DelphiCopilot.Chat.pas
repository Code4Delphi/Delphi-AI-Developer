unit DelphiCopilot.Chat;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Classes,
  RESTRequest4D,
  DelphiCopilot.Utils,
  DelphiCopilot.Settings;

type
  TDelphiCopilotChat = class
  private
    FSettings: TDelphiCopilotSettings;
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
  FSettings := TDelphiCopilotSettings.GetInstance;
  FSettings.LoadData;
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
  LJsonValue: TJSONVALUE;
  LJsonArray: TJsonArray;
  LPartsArray: TJsonArray;
  LJsonObj: TJsonObject;
  LPartsObj: TJsonObject;
  LJsonText: string;
  i, j: Integer;
begin
  FResponse.Clear;

  TDelphiCopilotUtils.ShowMsg('');

  LResponse := TRequest.New
    .BaseURL(Format(FSettings.BaseUrlGemini, [FSettings.ApiKeyGemini])) //API_URL - API_KEY
    .Accept('application/json')
    .AddBody(Format(API_JSON_BODY_BASE, [AQuestion]))
    .Post;

  if LResponse.StatusCode <> 200 then
  begin
    FResponse.Add('Question cannot be answered');
    FResponse.Add('Return: ' + LResponse.Content);
    Exit;
  end;

  LJsonValue := TJsonObject.ParseJSONValue(LResponse.Content);
  if LJsonValue is TJsonObject then
  begin
    LJsonArray := (LJsonValue as TJsonObject).GetValue<TJsonArray>('candidates');
    for i := 0 to LJsonArray.Count - 1 do
    begin
      LJsonObj := LJsonArray.Items[i].GetValue<TJsonObject>('content');
      LPartsArray := LJsonObj.GetValue<TJsonArray>('parts');
      for j := 0 to LPartsArray.Count - 1 do
      begin
        LPartsObj := LPartsArray.Items[j] as TJsonObject;
        LJsonText := LPartsObj.GetValue<string>('text');
        //FResponse.Add(TDelphiCopilotUtils.ConfReturnAI(JsonText));
        FResponse.Text := LJsonText;
      end;
    end;
  end;
end;

function TDelphiCopilotChat.Response: TStrings;
begin
  Result := FResponse;
end;

end.
