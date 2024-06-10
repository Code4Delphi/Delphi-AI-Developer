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

    const
    FIELD_AIDefault = 'AIDefault';
    FIELD_BaseUrlGemini = 'BaseUrlGemini';
    FIELD_ModelGemini = 'ModelGemini';
    FIELD_ApiKeyGemini = 'ApiKeyGemini';
    FIELD_TimeoutGemini = 'TimeoutGemini';
    FIELD_BaseUrlOpenAI = 'BaseUrlOpenAI';
    FIELD_ModelOpenAI = 'ModelOpenAI';
    FIELD_ApiKeyOpenAI = 'ApiKeyOpenAI';
    FIELD_TimeoutOpenAI = 'TimeoutOpenAI';

    constructor Create;
  public
    class function GetInstance: TDelphiCopilotSettings;
    procedure LoadDefaults;
    procedure SaveData;
    procedure LoadData;

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

var
  Instance: TDelphiCopilotSettings;

class function TDelphiCopilotSettings.GetInstance: TDelphiCopilotSettings;
begin
  if not Assigned(Instance) then
    Instance := Self.Create;
  Result := Instance;
end;

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

procedure TDelphiCopilotSettings.SaveData;
var
  LReg: TRegistry;
begin
  LReg := TRegistry.Create;
  try
    LReg.CloseKey;
    LReg.RootKey := HKEY_CURRENT_USER;
    if not(LReg.OpenKey(TC4DConsts.KEY_SETTINGS_IN_WINDOWS_REGISTRY, True))then
      raise Exception.Create('Unable to save settings to Windows registry');

    LReg.WriteInteger(FIELD_AIDefault, Integer(FAIDefault));

    LReg.WriteString(FIELD_BaseUrlGemini, FBaseUrlGemini);
    LReg.WriteString(FIELD_ModelGemini, FModelGemini);
    LReg.WriteString(FIELD_ApiKeyGemini, FApiKeyGemini);
    LReg.WriteInteger(FIELD_TimeoutGemini, FTimeoutGemini);

    LReg.WriteString(FIELD_BaseUrlOpenAI, FBaseUrlOpenAI);
    LReg.WriteString(FIELD_ModelOpenAI, FModelOpenAI);
    LReg.WriteString(FIELD_ApiKeyOpenAI, FApiKeyOpenAI);
    LReg.WriteInteger(FIELD_TimeoutOpenAI, FTimeoutOpenAI);
  finally
    LReg.Free;
  end;
end;

procedure TDelphiCopilotSettings.LoadData;
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

      //if LReg.ValueExists(FIELD_AIDefault) then
        FAIDefault := TAIsAvailable(LReg.ReadInteger(FIELD_AIDefault));

      //GEMINI
      if LReg.ValueExists(FIELD_BaseUrlGemini) then
        FBaseUrlGemini := LReg.ReadString(FIELD_BaseUrlGemini);

      if LReg.ValueExists(FIELD_ModelGemini) then
        FModelGemini := LReg.ReadString(FIELD_ModelGemini);

      if LReg.ValueExists(FIELD_ApiKeyGemini) then
        FApiKeyGemini := LReg.ReadString(FIELD_ApiKeyGemini);

      if LReg.ValueExists(FIELD_TimeoutGemini) then
        FTimeoutGemini := LReg.ReadInteger(FIELD_TimeoutGemini);

      //OPEN AI
      if LReg.ValueExists(FIELD_BaseUrlOpenAI) then
        fBaseUrlOpenAI := LReg.ReadString(FIELD_BaseUrlOpenAI);

      if LReg.ValueExists(FIELD_ModelOpenAI) then
        fModelOpenAI := LReg.ReadString(FIELD_ModelOpenAI);

      if LReg.ValueExists(FIELD_ApiKeyOpenAI) then
        fApiKeyOpenAI := LReg.ReadString(FIELD_ApiKeyOpenAI);

      if LReg.ValueExists(FIELD_TimeoutOpenAI) then
        fTimeoutOpenAI := LReg.ReadInteger(FIELD_TimeoutOpenAI);
    except
      Self.LoadDefaults;
    end;
  finally
    LReg.Free;
  end;
end;

end.
