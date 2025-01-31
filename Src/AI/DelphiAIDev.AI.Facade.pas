unit DelphiAIDev.AI.Facade;

interface

uses
  System.SysUtils,
  System.Classes,
  DelphiAIDev.Utils,
  DelphiAIDev.Types,
  DelphiAIDev.Settings,
  DelphiAIDev.AI.Interfaces,
  DelphiAIDev.AI.Response,
  DelphiAIDev.AI.Gemini,
  DelphiAIDev.AI.ChatGPT,
  DelphiAIDev.AI.Groq,
  DelphiAIDev.AI.Mistral,
  DelphiAIDev.AI.Ollama;

type
  IDelphiAIDevAIResponse = DelphiAIDev.AI.Interfaces.IDelphiAIDevAIResponse;

  TDelphiAIDevAIFacade = class
  private
    FAiUse: TC4DAiAvailable;
    FSettings: TDelphiAIDevSettings;
    FResponse: IDelphiAIDevAIResponse;
  public
    constructor Create;
    destructor Destroy; override;
    function AiUse(const Value: TC4DAiAvailable): TDelphiAIDevAIFacade;
    function ProcessSend(const AQuestion: string): TDelphiAIDevAIFacade;
    function Response: IDelphiAIDevAIResponse;
  end;

implementation

constructor TDelphiAIDevAIFacade.Create;
begin
  FSettings := TDelphiAIDevSettings.GetInstance;
  FSettings.LoadData;
  FAiUse := FSettings.AIDefault;
  FResponse := TDelphiAIDevAIResponse.New;
end;

destructor TDelphiAIDevAIFacade.Destroy;
begin
  inherited;
end;

function TDelphiAIDevAIFacade.AiUse(const Value: TC4DAiAvailable): TDelphiAIDevAIFacade;
begin
  Result := Self;
  FAiUse := Value;
end;

function TDelphiAIDevAIFacade.ProcessSend(const AQuestion: string): TDelphiAIDevAIFacade;
var
  LQuestion: string;
  LRequest: IDelphiAIDevAI;
begin
  Result := Self;
  LQuestion := TUtils.AdjustQuestionToJson(AQuestion);

  if TUtils.DebugMyIsOn then
    TUtils.AddLogDeleteFileFirst(LQuestion, 'DelphiAIDevAI_ProcessSend');

  case FAiUse of
    TC4DAiAvailable.Gemini:
      LRequest := TDelphiAIDevAIGemini.Create(FSettings, FResponse);
    TC4DAiAvailable.OpenAI:
      LRequest := TDelphiAIDevAIChatGPT.Create(FSettings, FResponse);
    TC4DAiAvailable.Groq:
      LRequest := TDelphiAIDevAIGroq.Create(FSettings, FResponse);
    TC4DAiAvailable.Mistral:
      LRequest := TDelphiAIDevAIMistral.Create(FSettings, FResponse);
    TC4DAiAvailable.Ollama:
      LRequest := TDelphiAIDevAIOllama.Create(FSettings, FResponse);
  else
    FResponse.SetContentText('Default AI not reported in Delphi AI Developer settings');
    Exit;
  end;

  LRequest.GetResponse(LQuestion);
end;

function TDelphiAIDevAIFacade.Response: IDelphiAIDevAIResponse;
begin
  Result := FResponse;
end;

end.
