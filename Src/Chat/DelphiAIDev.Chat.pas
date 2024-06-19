unit DelphiAIDev.Chat;

interface

uses
  System.SysUtils,
  System.Classes,
  DelphiAIDev.Types,
  DelphiAIDev.Settings,
  DelphiAIDev.AI.Gemini,
  DelphiAIDev.AI.ChatGPT;

type
  TDelphiAIDevChat = class
  private
    FSettings: TDelphiAIDevSettings;
    FResponse: TStrings;
  public
    constructor Create;
    destructor Destroy; override;
    function Settings: TDelphiAIDevSettings;
    procedure ProcessSend(const AQuestion: string);
    function Response: TStrings;
  end;

implementation

constructor TDelphiAIDevChat.Create;
begin
  FSettings := TDelphiAIDevSettings.GetInstance;
  FSettings.LoadData;
  FResponse := TStringList.Create;
end;

destructor TDelphiAIDevChat.Destroy;
begin
  FResponse.Free;
  inherited;
end;

function TDelphiAIDevChat.Settings: TDelphiAIDevSettings;
begin
  Result := FSettings;
end;

procedure TDelphiAIDevChat.ProcessSend(const AQuestion: string);
begin
  FResponse.Clear;

  case FSettings.AIDefault of
    TC4DAIsAvailable.Gemini:
      FResponse.Text := TDelphiAIDevAIGemini.New(FSettings).GetResponse(AQuestion);
    TC4DAIsAvailable.OpenAI:
      FResponse.Text := TDelphiAIDevAIChatGPT.New(FSettings).GetResponse(AQuestion);
  else
    FResponse.Add('Default AI not reported in Delphi AI Developer settings');
  end;
end;

function TDelphiAIDevChat.Response: TStrings;
begin
  Result := FResponse;
end;

end.
