unit DelphiCopilot.Chat;

interface

uses
  System.SysUtils,
  System.Classes,
  DelphiCopilot.Types,
  DelphiCopilot.Settings,
  DelphiCopilot.AI.Gemini,
  DelphiCopilot.AI.ChatGPT;

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
begin
  FResponse.Clear;

  case FSettings.AIDefault of
    TAIsAvailable.Gemini:
      FResponse.Text := TDelphiCopilotAIGemini.New(FSettings).GetResponse(AQuestion);
    TAIsAvailable.OpenAI:
      FResponse.Text := TDelphiCopilotAIChatGPT.New(FSettings).GetResponse(AQuestion);
  else
    FResponse.Add('Default AI not reported in Copilot settings');
  end;
end;

function TDelphiCopilotChat.Response: TStrings;
begin
  Result := FResponse;
end;

end.
