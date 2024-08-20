unit DelphiAIDev.Chat;

interface

uses
  System.SysUtils,
  System.Classes,
  DelphiAIDev.Utils,
  DelphiAIDev.Types,
  DelphiAIDev.Settings,
  DelphiAIDev.AI.Gemini,
  DelphiAIDev.AI.ChatGPT,
  DelphiAIDev.AI.Groq;

type
  TDelphiAIDevChat = class
  private
    FSettings: TDelphiAIDevSettings;
    FResponse: TStrings;
  public
    constructor Create;
    destructor Destroy; override;
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

procedure TDelphiAIDevChat.ProcessSend(const AQuestion: string);
var
  LQuestion: string;
begin
  LQuestion := TUtils.AdjustQuestionToJson(AQuestion);
  TUtils.ShowMsgSynchronize('LQuestion', LQuestion);
  FResponse.Clear;

  case FSettings.AIDefault of
    TC4DAIsAvailable.Gemini:
      FResponse.Text := TDelphiAIDevAIGemini.New(FSettings).GetResponse(LQuestion);
    TC4DAIsAvailable.OpenAI:
      FResponse.Text := TDelphiAIDevAIChatGPT.New(FSettings).GetResponse(LQuestion);
    TC4DAIsAvailable.Groq:
      FResponse.Text := TDelphiAIDevAIGroq.New(FSettings).GetResponse(LQuestion);
  else
    FResponse.Text := 'Default AI not reported in Delphi AI Developer settings';
  end;
end;

function TDelphiAIDevChat.Response: TStrings;
begin
  Result := FResponse;
end;

end.
