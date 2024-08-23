unit DelphiAIDev.Settings;

interface

uses
  System.SysUtils,
  System.Win.Registry,
  Winapi.Windows,
  Vcl.Graphics,
  DelphiAIDev.Types,
  DelphiAIDev.Consts,
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA;

type
  TDelphiAIDevSettings = class
  private const
    FIELD_LanguageQuestions =  'LanguageQuestions';
    FIELD_AIDefault = 'AIDefault';
    FIELD_ColorHighlightCodeDelphiUse = 'ColorHighlightCodeDelphiUse';
    FIELD_ColorHighlightCodeDelphi =  'ColorHighlightCodeDelphi';
    FIELD_BaseUrlGemini = 'BaseUrlGemini';
    FIELD_ModelGemini = 'ModelGemini';
    FIELD_ApiKeyGemini = 'ApiKeyGemini';
    FIELD_BaseUrlOpenAI = 'BaseUrlOpenAI';
    FIELD_ModelOpenAI = 'ModelOpenAI';
    FIELD_ApiKeyOpenAI = 'ApiKeyOpenAI';
    FIELD_BaseUrlGroq = 'BaseUrlGroq';
    FIELD_ModelGroq = 'ModelGroq';
    FIELD_ApiKeyGroq = 'ApiKeyGroq';
    FIELD_BaseUrlOllama = 'BaseUrlOllama';
    FIELD_ModelOllama = 'ModelOllama';
    FIELD_ApiKeyOllama = 'ApiKeyOllama';
  private
    FLanguageQuestions: TC4DLanguage;
    FAIDefault: TC4DAIsAvailable;
    FColorHighlightCodeDelphiUse: Boolean;
    FColorHighlightCodeDelphi: TColor;

    FBaseUrlGemini: string;
    FModelGemini: string;
    FApiKeyGemini: string;

    FBaseUrlOpenAI: string;
    FModelOpenAI: string;
    FApiKeyOpenAI: string;

    FBaseUrlGroq: string;
    FModelGroq: string;
    FApiKeyGroq: string;

    FBaseUrlOllama: string;
    FModelOllama: string;
    FApiKeyOllama: string;

    constructor Create;
  public
    class function GetInstance: TDelphiAIDevSettings;
    procedure LoadDefaults;
    procedure SaveData;
    procedure LoadData;
    procedure ValidateFillingSelectedAI;

    property LanguageQuestions: TC4DLanguage read FLanguageQuestions write FLanguageQuestions;
    property AIDefault: TC4DAIsAvailable read FAIDefault write FAIDefault;
    property ColorHighlightCodeDelphiUse: Boolean read FColorHighlightCodeDelphiUse write FColorHighlightCodeDelphiUse;
    property ColorHighlightCodeDelphi: TColor read FColorHighlightCodeDelphi write FColorHighlightCodeDelphi;

    property BaseUrlGemini: string read FBaseUrlGemini write FBaseUrlGemini;
    property ModelGemini: string read FModelGemini write FModelGemini;
    property ApiKeyGemini: string read FApiKeyGemini write FApiKeyGemini;

    property BaseUrlOpenAI: string read FBaseUrlOpenAI write FBaseUrlOpenAI;
    property ModelOpenAI: string read FModelOpenAI write FModelOpenAI;
    property ApiKeyOpenAI: string read FApiKeyOpenAI write FApiKeyOpenAI;

    property BaseUrlGroq: string read FBaseUrlGroq write FBaseUrlGroq;
    property ModelGroq: string read FModelGroq write FModelGroq;
    property ApiKeyGroq: string read FApiKeyGroq write FApiKeyGroq;

    property BaseUrlOllama: string read FBaseUrlOllama write FBaseUrlOllama;
    property ModelOllama: string read FModelOllama write FModelOllama;
    property ApiKeyOllama: string read FApiKeyOllama write FApiKeyOllama;
  end;

implementation

var
  Instance: TDelphiAIDevSettings;

class function TDelphiAIDevSettings.GetInstance: TDelphiAIDevSettings;
begin
  if not Assigned(Instance) then
    Instance := Self.Create;
  Result := Instance;
end;

constructor TDelphiAIDevSettings.Create;
begin
  Self.LoadDefaults;
end;

procedure TDelphiAIDevSettings.LoadDefaults;
begin
  FLanguageQuestions := TC4DLanguage.ptBR;
  FAIDefault := TC4DAIsAvailable.Groq;

  FColorHighlightCodeDelphiUse := False;
  FColorHighlightCodeDelphi := clNone;

  FBaseUrlGemini := TConsts.BASE_URL_GEMINI_DEFAULT;
  FModelGemini := TConsts.MODEL_GEMINI_DEFAULT;
  FApiKeyGemini := '';

  FBaseUrlOpenAI := TConsts.BASE_URL_OPEN_AI;
  FModelOpenAI := TConsts.MODEL_OPEN_AI_DEFAULT;
  FApiKeyOpenAI := '';

  FBaseUrlGroq := TConsts.BASE_URL_GROQ;
  FModelGroq := TConsts.MODEL_GROQ_DEFAULT;
  FApiKeyGroq := '';

  FBaseUrlOllama := TConsts.BASE_URL_OLLAMA;
  FModelOllama := TConsts.MODEL_OLLAMA_DEFAULT;
  FApiKeyOllama := '';
end;

procedure TDelphiAIDevSettings.SaveData;
var
  LReg: TRegistry;
begin
  LReg := TRegistry.Create;
  try
    LReg.CloseKey;
    LReg.RootKey := HKEY_CURRENT_USER;
    if not(LReg.OpenKey(TConsts.KEY_SETTINGS_IN_WINDOWS_REGISTRY, True))then
      raise Exception.Create('Unable to save settings to Windows registry');

    LReg.WriteInteger(FIELD_LanguageQuestions, Integer(FLanguageQuestions));
    LReg.WriteInteger(FIELD_AIDefault, Integer(FAIDefault));

    LReg.WriteBool(FIELD_ColorHighlightCodeDelphiUse, FColorHighlightCodeDelphiUse);
    LReg.WriteString(FIELD_ColorHighlightCodeDelphi, ColorToString(FColorHighlightCodeDelphi));

    LReg.WriteString(FIELD_BaseUrlGemini, FBaseUrlGemini);
    LReg.WriteString(FIELD_ModelGemini, FModelGemini);
    LReg.WriteString(FIELD_ApiKeyGemini, FApiKeyGemini);

    LReg.WriteString(FIELD_BaseUrlOpenAI, FBaseUrlOpenAI);
    LReg.WriteString(FIELD_ModelOpenAI, FModelOpenAI);
    LReg.WriteString(FIELD_ApiKeyOpenAI, FApiKeyOpenAI);

    LReg.WriteString(FIELD_BaseUrlGroq, FBaseUrlGroq);
    LReg.WriteString(FIELD_ModelGroq, FModelGroq);
    LReg.WriteString(FIELD_ApiKeyGroq, FApiKeyGroq);

    LReg.WriteString(FIELD_BaseUrlOllama, FBaseUrlOllama);
    LReg.WriteString(FIELD_ModelOllama, FModelOllama);
    LReg.WriteString(FIELD_ApiKeyOllama, FApiKeyOllama);
  finally
    LReg.Free;
  end;
end;

procedure TDelphiAIDevSettings.LoadData;
var
  LReg: TRegistry;
begin
  Self.LoadDefaults;
  LReg := TRegistry.Create;
  try
    try
      LReg.CloseKey;
      LReg.RootKey := HKEY_CURRENT_USER;

      if not(LReg.OpenKey(TConsts.KEY_SETTINGS_IN_WINDOWS_REGISTRY, False)) then
        Exit;

      if LReg.ValueExists(FIELD_LanguageQuestions) then
        FLanguageQuestions := TC4DLanguage(LReg.ReadInteger(FIELD_LanguageQuestions));

      if LReg.ValueExists(FIELD_AIDefault) then
        FAIDefault := TC4DAIsAvailable(LReg.ReadInteger(FIELD_AIDefault));

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

      //GROQ
      if LReg.ValueExists(FIELD_BaseUrlGroq) then
        fBaseUrlGroq := LReg.ReadString(FIELD_BaseUrlGroq);

      if LReg.ValueExists(FIELD_ModelGroq) then
        fModelGroq := LReg.ReadString(FIELD_ModelGroq);

      if LReg.ValueExists(FIELD_ApiKeyGroq) then
        fApiKeyGroq := LReg.ReadString(FIELD_ApiKeyGroq);

      //OLLAMA
      if LReg.ValueExists(FIELD_BaseUrlOllama) then
        fBaseUrlOllama := LReg.ReadString(FIELD_BaseUrlOllama);

      if LReg.ValueExists(FIELD_ModelOllama) then
        fModelOllama := LReg.ReadString(FIELD_ModelOllama);

      if LReg.ValueExists(FIELD_ApiKeyOllama) then
        fApiKeyOllama := LReg.ReadString(FIELD_ApiKeyOllama);
    except
      Self.LoadDefaults;
    end;
  finally
    LReg.Free;
  end;
end;

procedure TDelphiAIDevSettings.ValidateFillingSelectedAI;
const
  MSG = '"%s" for IA %s not specified in settings.' + sLineBreak + sLineBreak +
    'Access menu > AI Developer > Settings';
begin
  case FAIDefault of
    TC4DAIsAvailable.Gemini:
    begin
      if FBaseUrlGemini.Trim.IsEmpty then
        TUtils.ShowMsgAndAbort(Format(MSG, ['Base URL', 'Gemini']));

      if FModelGemini.Trim.IsEmpty then
        TUtils.ShowMsgAndAbort(Format(MSG, ['Model', 'Gemini']));

      if FApiKeyGemini.Trim.IsEmpty then
        TUtils.ShowMsgAndAbort(Format(MSG, ['API Key', 'Gemini']));
    end;
    TC4DAIsAvailable.OpenAI:
    begin
      if FBaseUrlOpenAI.Trim.IsEmpty then
        TUtils.ShowMsgAndAbort(Format(MSG, ['Base URL', 'ChatGPT']));

      if FModelOpenAI.Trim.IsEmpty then
        TUtils.ShowMsgAndAbort(Format(MSG, ['Model', 'ChatGPT']));

      if FApiKeyOpenAI.Trim.IsEmpty then
        TUtils.ShowMsgAndAbort(Format(MSG, ['API Key', 'ChatGPT']));
    end;
    TC4DAIsAvailable.Groq:
    begin
      if FBaseUrlGroq.Trim.IsEmpty then
        TUtils.ShowMsgAndAbort(Format(MSG, ['Base URL', 'Groq']));

      if FModelGroq.Trim.IsEmpty then
        TUtils.ShowMsgAndAbort(Format(MSG, ['Model', 'Groq']));

      if FApiKeyGroq.Trim.IsEmpty then
        TUtils.ShowMsgAndAbort(Format(MSG, ['API Key', 'Groq']));
    end;
    TC4DAIsAvailable.Ollama:
    begin
      if FBaseUrlOllama.Trim.IsEmpty then
        TUtils.ShowMsgAndAbort(Format(MSG, ['Base URL', 'Ollama']));

      if FModelOllama.Trim.IsEmpty then
        TUtils.ShowMsgAndAbort(Format(MSG, ['Model', 'Ollama']));
    end;
  end;
end;

initialization

finalization
  if Assigned(Instance) then
    FreeAndNil(Instance);

end.
