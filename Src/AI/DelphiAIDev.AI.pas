unit DelphiAIDev.AI;

interface

uses
  System.SysUtils,
  System.Classes,
  DelphiAIDev.Utils,
  DelphiAIDev.Types,
  DelphiAIDev.Settings,
  DelphiAIDev.AI.Gemini,
  DelphiAIDev.AI.ChatGPT,
  DelphiAIDev.AI.Groq,
  DelphiAIDev.AI.Ollama;

type
  TDelphiAIDevAI = class
  private
    FAiUse: TC4DAiAvailable;
    FSettings: TDelphiAIDevSettings;
    FResponse: TStrings;
  public
    constructor Create;
    destructor Destroy; override;
    function AiUse(const Value: TC4DAiAvailable): TDelphiAIDevAI;
    procedure ProcessSend(const AQuestion: string);
    function Response: TStrings;
  end;

implementation

constructor TDelphiAIDevAI.Create;
begin
  FSettings := TDelphiAIDevSettings.GetInstance;
  FSettings.LoadData;
  FAiUse := FSettings.AIDefault;
  FResponse := TStringList.Create;
end;

destructor TDelphiAIDevAI.Destroy;
begin
  FResponse.Free;
  inherited;
end;

function TDelphiAIDevAI.AiUse(const Value: TC4DAiAvailable): TDelphiAIDevAI;
begin
  Result := Self;
  FAiUse := Value;
end;

procedure TDelphiAIDevAI.ProcessSend(const AQuestion: string);
var
  LQuestion: string;
begin
  LQuestion := TUtils.AdjustQuestionToJson(AQuestion);
  FResponse.Clear;

  if TUtils.DebugMyIsOn then
    TUtils.AddLogDeleteFileFirst(LQuestion, 'DelphiAIDevAI_ProcessSend');

  case FAiUse of
    TC4DAiAvailable.Gemini:
      FResponse.Text := TDelphiAIDevAIGemini.New(FSettings).GetResponse(LQuestion);
    TC4DAiAvailable.OpenAI:
      FResponse.Text := TDelphiAIDevAIChatGPT.New(FSettings).GetResponse(LQuestion);
    TC4DAiAvailable.Groq:
      FResponse.Text := TDelphiAIDevAIGroq.New(FSettings).GetResponse(LQuestion);
    TC4DAiAvailable.Ollama:
      FResponse.Text := TDelphiAIDevAIOllama.New(FSettings).GetResponse(LQuestion);
  else
    FResponse.Text := 'Default AI not reported in Delphi AI Developer settings';
  end;
end;

function TDelphiAIDevAI.Response: TStrings;
begin
  Result := FResponse;
end;

end.
