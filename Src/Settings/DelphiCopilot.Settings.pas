unit DelphiCopilot.Settings;

interface

uses
  System.SysUtils,
  System.Win.Registry,
  Winapi.Windows,
  Vcl.Graphics,
  DelphiCopilot.Types,
  DelphiCopilot.Consts,
  DelphiCopilot.Utils,
  DelphiCopilot.Utils.OTA;

type
  TDelphiCopilotSettings = class
  private
    FAIDefault: TAIsAvailable;
    FColorHighlightCodeDelphiUse: Boolean;
    FColorHighlightCodeDelphi: TColor;

    FBaseUrlGemini: string;
    FModelGemini: string;
    FApiKeyGemini: string;

    FBaseUrlOpenAI: string;
    FModelOpenAI: string;
    FApiKeyOpenAI: string;

    const
    FIELD_AIDefault = 'AIDefault';
    FIELD_ColorHighlightCodeDelphiUse = 'ColorHighlightCodeDelphiUse';
    FIELD_ColorHighlightCodeDelphi =  'ColorHighlightCodeDelphi';
    FIELD_BaseUrlGemini = 'BaseUrlGemini';
    FIELD_ModelGemini = 'ModelGemini';
    FIELD_ApiKeyGemini = 'ApiKeyGemini';
    FIELD_BaseUrlOpenAI = 'BaseUrlOpenAI';
    FIELD_ModelOpenAI = 'ModelOpenAI';
    FIELD_ApiKeyOpenAI = 'ApiKeyOpenAI';

    constructor Create;
  public
    class function GetInstance: TDelphiCopilotSettings;
    procedure LoadDefaults;
    procedure SaveData;
    procedure LoadData;

    property AIDefault: TAIsAvailable read FAIDefault write FAIDefault;
    property ColorHighlightCodeDelphiUse: Boolean read FColorHighlightCodeDelphiUse write FColorHighlightCodeDelphiUse;
    property ColorHighlightCodeDelphi: TColor read FColorHighlightCodeDelphi write FColorHighlightCodeDelphi;


    property BaseUrlGemini: string read FBaseUrlGemini write FBaseUrlGemini;
    property ModelGemini: string read FModelGemini write FModelGemini;
    property ApiKeyGemini: string read FApiKeyGemini write FApiKeyGemini;

    property BaseUrlOpenAI: string read FBaseUrlOpenAI write FBaseUrlOpenAI;
    property ModelOpenAI: string read FModelOpenAI write FModelOpenAI;
    property ApiKeyOpenAI: string read FApiKeyOpenAI write FApiKeyOpenAI;
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

  FColorHighlightCodeDelphiUse := False;
  FColorHighlightCodeDelphi := clNone;

  FBaseUrlGemini := TC4DConsts.BASE_URL_GEMINI_DEFAULT;
  FModelGemini := TC4DConsts.MODEL_GEMINI_DEFAULT;
  FApiKeyGemini := '';

  FBaseUrlOpenAI := TC4DConsts.BASE_URL_OPEN_AI;
  FModelOpenAI := 'gpt-3.5-turbo';
  FApiKeyOpenAI := '';
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

    LReg.WriteBool(FIELD_ColorHighlightCodeDelphiUse, FColorHighlightCodeDelphiUse);
    LReg.WriteString(FIELD_ColorHighlightCodeDelphi, ColorToString(FColorHighlightCodeDelphi));

    LReg.WriteString(FIELD_BaseUrlGemini, FBaseUrlGemini);
    LReg.WriteString(FIELD_ModelGemini, FModelGemini);
    LReg.WriteString(FIELD_ApiKeyGemini, FApiKeyGemini);

    LReg.WriteString(FIELD_BaseUrlOpenAI, FBaseUrlOpenAI);
    LReg.WriteString(FIELD_ModelOpenAI, FModelOpenAI);
    LReg.WriteString(FIELD_ApiKeyOpenAI, FApiKeyOpenAI);
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

      if LReg.ValueExists(FIELD_AIDefault) then
        FAIDefault := TAIsAvailable(LReg.ReadInteger(FIELD_AIDefault));

      //COLOR FOR HIGHLIGHT CODE DELPHI/PASCAL
      if LReg.ValueExists(FIELD_ColorHighlightCodeDelphiUse) then
        FColorHighlightCodeDelphiUse := LReg.ReadBool(FIELD_ColorHighlightCodeDelphiUse);

      if LReg.ValueExists(FIELD_ColorHighlightCodeDelphi) then
        FColorHighlightCodeDelphi := TUtils.StringToColorDef(LReg.ReadString(FIELD_ColorHighlightCodeDelphi),
          TUtilsOTA.ActiveThemeForCode);

      //GEMINI
      if LReg.ValueExists(FIELD_BaseUrlGemini) then
        FBaseUrlGemini := LReg.ReadString(FIELD_BaseUrlGemini);

      if LReg.ValueExists(FIELD_ModelGemini) then
        FModelGemini := LReg.ReadString(FIELD_ModelGemini);

      if LReg.ValueExists(FIELD_ApiKeyGemini) then
        FApiKeyGemini := LReg.ReadString(FIELD_ApiKeyGemini);

      //OPEN AI
      if LReg.ValueExists(FIELD_BaseUrlOpenAI) then
        fBaseUrlOpenAI := LReg.ReadString(FIELD_BaseUrlOpenAI);

      if LReg.ValueExists(FIELD_ModelOpenAI) then
        fModelOpenAI := LReg.ReadString(FIELD_ModelOpenAI);

      if LReg.ValueExists(FIELD_ApiKeyOpenAI) then
        fApiKeyOpenAI := LReg.ReadString(FIELD_ApiKeyOpenAI);
    except
      Self.LoadDefaults;
    end;
  finally
    LReg.Free;
  end;
end;

initialization

finalization
  if Assigned(Instance) then
    FreeAndNil(Instance);

end.
