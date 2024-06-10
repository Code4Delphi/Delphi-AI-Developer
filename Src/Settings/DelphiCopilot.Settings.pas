unit DelphiCopilot.Settings;

interface

uses
  System.SysUtils,
  System.Win.Registry,
  Winapi.Windows,
  DelphiCopilot.Types,
  DelphiCopilot.Consts;

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

  FBaseUrlGemini := TC4DConsts.BASE_URL_GEMINI_DEFAULT;
  FModelGemini := TC4DConsts.MODEL_GEMINI_DEFAULT;
  FApiKeyGemini := '';
  FTimeoutGemini := TC4DConsts.API_AI_TIMEOUT_DEFAULT;

  FBaseUrlOpenAI := TC4DConsts.BASE_URL_OPEN_AI;
  FModelOpenAI := '';
  FApiKeyOpenAI := '';
  FTimeoutOpenAI := TC4DConsts.API_AI_TIMEOUT_DEFAULT;
end;

procedure TDelphiCopilotSettings.WriteToWindowsRegistry;
var
  LReg: TRegistry;
begin
  LReg := TRegistry.Create;
  try
    LReg.CloseKey;
    LReg.RootKey := HKEY_CURRENT_USER;
    if not(LReg.OpenKey(TC4DConsts.KEY_SETTINGS_IN_WINDOWS_REGISTRY, True))then
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

      if not(LReg.OpenKey(TC4DConsts.KEY_SETTINGS_IN_WINDOWS_REGISTRY, False)) then
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
