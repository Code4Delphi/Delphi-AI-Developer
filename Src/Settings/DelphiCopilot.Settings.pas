unit DelphiCopilot.Settings;

interface

uses
  System.SysUtils,
  System.Win.Registry,
  Winapi.Windows,
  DelphiCopilot.Types;

type
  TDelphiCopilotSettings = class
  private
    FAIDefault: TAIsAvailable;
    FBaseUrlGemini: string;
    FModelGemini: string;
    FApiKeyGemini: string;
    FTimeoutGemini: Integer;

    FBaseUrlOpenAI: string;
    FModelOpenAI: string;
    FApiKeyOpenAI: string;
    FTimeoutOpenAI: Integer;
  public
    constructor Create;
    procedure LoadDefaults;
    procedure WriteToWindowsRegistry;
    procedure ReadFromWindowsRegistry;

    property AIDefault: TAIsAvailable read FAIDefault write FAIDefault;

    property BaseUrlGemini: string read FBaseUrlGemini write FBaseUrlGemini;
    property ModelGemini: string read FModelGemini write FModelGemini;
    property ApiKeyGemini: string read FApiKeyGemini write FApiKeyGemini;
    property TimeoutGemini: Integer read FTimeoutGemini write FTimeoutGemini;

    property BaseUrlOpenAI: string read FBaseUrlOpenAI write FBaseUrlOpenAI;
    property ModelOpenAI: string read FModelOpenAI write FModelOpenAI;
    property ApiKeyOpenAI: string read FApiKeyOpenAI write FApiKeyOpenAI;
    property TimeoutOpenAI: Integer read FTimeoutOpenAI write FTimeoutOpenAI;
  end;

implementation


constructor TDelphiCopilotSettings.Create;
begin
  Self.LoadDefaults;
end;

procedure TDelphiCopilotSettings.LoadDefaults;
begin
  FAIDefault := TAIsAvailable.Gemini;

  FBaseUrlGemini := 'https://generativelanguage.googleapis.com/';
  FModelGemini := 'v1/models/gemini-1.5-flash:generateContent';
  FApiKeyGemini := '';
  FTimeoutGemini := 20;

  FBaseUrlOpenAI := 'https://api.openai.com/v1/chat/completions/';
  FModelOpenAI := '';
  FApiKeyOpenAI := '';
  FTimeoutOpenAI := 20;
end;

procedure TDelphiCopilotSettings.WriteToWindowsRegistry;
var
  LReg: TRegistry;
begin
  LReg := TRegistry.Create;
  try
    LReg.CloseKey;
    LReg.RootKey := HKEY_CURRENT_USER;
    if not(LReg.OpenKey('\SOFTWARE\DelphiCopilotC4D', True))then
      raise Exception.Create('Unable to save settings to Windows registry');

    LReg.WriteInteger('AIDefault', Integer(FAIDefault));

    LReg.WriteString('BaseUrlGemini', FBaseUrlGemini);
    LReg.WriteString('ModelGemini', FModelGemini);
    LReg.WriteString('ApiKeyGemini', FApiKeyGemini);
    LReg.WriteInteger('TimeoutGemini', FTimeoutGemini);

    LReg.WriteString('BaseUrlOpenAI', FBaseUrlOpenAI);
    LReg.WriteString('ModelOpenAI', FModelOpenAI);
    LReg.WriteString('ApiKeyOpenAI', FApiKeyOpenAI);
    LReg.WriteInteger('TimeoutOpenAI', FTimeoutOpenAI);
  finally
    LReg.Free;
  end;
end;

procedure TDelphiCopilotSettings.ReadFromWindowsRegistry;
var
  LReg: TRegistry;
begin
  Self.LoadDefaults;
  LReg := TRegistry.Create;
  try
    try
      LReg.CloseKey;
      LReg.RootKey := HKEY_CURRENT_USER;

      if not(LReg.OpenKey('\SOFTWARE\ChatGPTWizard', False)) then
        Exit;

      if LReg.ValueExists('AIDefault') then
        FAIDefault := TAIsAvailable(LReg.ReadInteger('AIDefault'));

      //GEMINI
      if LReg.ValueExists('BaseUrlGemini') then
        FBaseUrlGemini := LReg.ReadString('BaseUrlGemini');

      if LReg.ValueExists('ModelGemini') then
        FModelGemini := LReg.ReadString('ModelGemini');

      if LReg.ValueExists('ApiKeyGemini') then
        FApiKeyGemini := LReg.ReadString('ApiKeyGemini');

      if LReg.ValueExists('TimeoutGemini') then
        FTimeoutGemini := LReg.ReadInteger('TimeoutGemini');

      //OPEN AI
      if LReg.ValueExists('BaseUrlOpenAI') then
        fBaseUrlOpenAI := LReg.ReadString('BaseUrlOpenAI');

      if LReg.ValueExists('ModelOpenAI') then
        fModelOpenAI := LReg.ReadString('ModelOpenAI');

      if LReg.ValueExists('ApiKeyOpenAI') then
        fApiKeyOpenAI := LReg.ReadString('ApiKeyOpenAI');

      if LReg.ValueExists('TimeoutOpenAI') then
        fTimeoutOpenAI := LReg.ReadInteger('TimeoutOpenAI');
    except
      Self.LoadDefaults;
    end;
  finally
    LReg.Free;
  end;
end;

end.
