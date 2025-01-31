unit DelphiAIDev.Settings.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.Menus,
  DelphiAIDev.Settings,
  DelphiAIDev.Types,
  DelphiAIDev.Consts;

type
  TDelphiAIDevSettingsView = class(TForm)
    pnBottom: TPanel;
    btnConfirm: TButton;
    btnClose: TButton;
    pnBackAll: TPanel;
    lbRestoreDefaults: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    pnMyControl: TPanel;
    pnMyControlButtons: TPanel;
    btnPreferences: TButton;
    btnIAsOnline: TButton;
    pnPreferencesBack: TPanel;
    GroupBox2: TGroupBox;
    Label11: TLabel;
    Label4: TLabel;
    cBoxAIDefault: TComboBox;
    ColorBoxColorHighlightCodeDelphi: TColorBox;
    ckColorHighlightCodeDelphiUse: TCheckBox;
    cBoxLanguageQuestions: TComboBox;
    TabSheet3: TTabSheet;
    pnIAsOffLineBack: TPanel;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    btnApiKeyOllamaView: TSpeedButton;
    lbLinkOllama02: TLabel;
    lbLinkOllama03: TLabel;
    lbLinkOllama01: TLabel;
    edtBaseUrlOllama: TEdit;
    edtApiKeyOllama: TEdit;
    cBoxModelOllama: TComboBox;
    TabSheet4: TTabSheet;
    pnCodeCompletionBack: TPanel;
    pnIAsOnLineBack: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    gBoxGemini: TGroupBox;
    pnGeminiBack: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lbLinkGemini01: TLabel;
    lbLinkGemini02: TLabel;
    btnApiKeyGeminiView: TSpeedButton;
    lbLinkGemini03: TLabel;
    edtBaseUrlGemini: TEdit;
    edtApiKeyGemini: TEdit;
    cBoxModelGemini: TComboBox;
    gBoxOpenAI: TGroupBox;
    pnOpenAIBack: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    lbLinkGpt01: TLabel;
    btnApiKeyOpenAIView: TSpeedButton;
    lbLinkGpt02: TLabel;
    edtBaseUrlOpenAI: TEdit;
    edtApiKeyOpenAI: TEdit;
    cBoxModelOpenAI: TComboBox;
    gBoxGroq: TGroupBox;
    pnGroqBack: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    lbLinkGroq01: TLabel;
    btnApiKeyGroqView: TSpeedButton;
    lbLinkGroq02: TLabel;
    lbLinkGroq03: TLabel;
    edtBaseUrlGroq: TEdit;
    edtApiKeyGroq: TEdit;
    cBoxModelGroq: TComboBox;
    pnBody: TPanel;
    btnIAsOffline: TButton;
    btnCodeCompletion: TButton;
    Bevel5: TBevel;
    GroupBox3: TGroupBox;
    Panel2: TPanel;
    ckCodeCompletionUse: TCheckBox;
    Label15: TLabel;
    cBoxCodeCompletionAIDefault: TComboBox;
    ColorBoxCodeCompletionSuggestionColor: TColorBox;
    ckCodeCompletionSuggestionColorUse: TCheckBox;
    Label16: TLabel;
    gboxData: TGroupBox;
    btnOpenDataFolder: TButton;
    edtCodeCompletionShortcutInvoke: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    mmCodeCompletionDefaultPrompt: TMemo;
    Label19: TLabel;
    mmDefaultPrompt: TMemo;
    gBoxMistral: TGroupBox;
    pnMistralBack: TPanel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    lbLinkMistral01: TLabel;
    btnApiKeyMistralView: TSpeedButton;
    lbLinkMistral02: TLabel;
    lbLinkMistral03: TLabel;
    edtBaseUrlMistral: TEdit;
    edtApiKeyMistral: TEdit;
    cBoxModelMistral: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure lbLinkGpt01Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure btnApiKeyGeminiViewClick(Sender: TObject);
    procedure btnApiKeyOpenAIViewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbRestoreDefaultsClick(Sender: TObject);
    procedure ckColorHighlightCodeDelphiUseClick(Sender: TObject);
    procedure btnApiKeyGroqViewClick(Sender: TObject);
    procedure btnApiKeyOllamaViewClick(Sender: TObject);
    procedure btnPreferencesClick(Sender: TObject);
    procedure btnIAsOnlineClick(Sender: TObject);
    procedure btnIAsOfflineClick(Sender: TObject);
    procedure btnCodeCompletionClick(Sender: TObject);
    procedure btnOpenDataFolderClick(Sender: TObject);
    procedure ckCodeCompletionSuggestionColorUseClick(Sender: TObject);
    procedure btnApiKeyMistralViewClick(Sender: TObject);
  private
    FSettings: TDelphiAIDevSettings;
    procedure SaveSettings;
    procedure LoadSettings;
    procedure ConfigScreen;
    procedure ConfigFieldsColorHighlightDelphi;
    procedure FillcBoxLanguageQuestions;
    procedure FillcBoxAIDefault;
    procedure FillcBoxCodeCompletionAIDefault;
    procedure ShowPanel(const AButton: TButton; const APanel: TPanel);
    procedure PanelsSetParent;
    procedure ValidateCodeCompletionShortcutInvoke;
    procedure ConfigFieldsCodeCompletionSuggestionColor;
  public

  end;

var
  DelphiAIDevSettingsView: TDelphiAIDevSettingsView;

implementation

uses
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA;

{$R *.dfm}

procedure TDelphiAIDevSettingsView.FormCreate(Sender: TObject);
begin
  TUtilsOTA.IDEThemingAll(TDelphiAIDevSettingsView, Self);
  FSettings := TDelphiAIDevSettings.GetInstance;

  Self.PanelsSetParent;
  Self.FillcBoxLanguageQuestions;
  Self.FillcBoxAIDefault;
  Self.FillcBoxCodeCompletionAIDefault;
end;

procedure TDelphiAIDevSettingsView.FormShow(Sender: TObject);
begin
  FSettings.LoadData;
  Self.ConfigScreen;
  Self.LoadSettings;
end;

procedure TDelphiAIDevSettingsView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FSettings.LoadData;
end;

procedure TDelphiAIDevSettingsView.FillcBoxLanguageQuestions;
var
  LItem: TC4DLanguage;
begin
  cBoxLanguageQuestions.Items.Clear;
  for LItem := Low(TC4DLanguage) to High(TC4DLanguage) do
    cBoxLanguageQuestions.Items.Add(LItem.ToString);
end;

procedure TDelphiAIDevSettingsView.FillcBoxAIDefault;
var
  LItem: TC4DAiAvailable;
begin
  cBoxAIDefault.Items.Clear;
  for LItem := Low(TC4DAiAvailable) to High(TC4DAiAvailable) do
    cBoxAIDefault.Items.Add(LItem.ToString);
end;

procedure TDelphiAIDevSettingsView.FillcBoxCodeCompletionAIDefault;
var
  LItem: TC4DAiAvailable;
begin
  cBoxCodeCompletionAIDefault.Items.Clear;
  for LItem := Low(TC4DAiAvailable) to High(TC4DAiAvailable) do
    cBoxCodeCompletionAIDefault.Items.Add(LItem.ToString);
end;

procedure TDelphiAIDevSettingsView.ConfigScreen;
var
  LColor: TColor;
begin
  LColor := TUtilsOTA.ActiveThemeColorLink;
  lbLinkGemini01.Font.Color := LColor;
  lbLinkGemini02.Font.Color := LColor;
  lbLinkGemini03.Font.Color := LColor;
  lbLinkGpt01.Font.Color := LColor;
  lbLinkGpt02.Font.Color := LColor;
  lbLinkGroq01.Font.Color := LColor;
  lbLinkGroq02.Font.Color := LColor;
  lbLinkGroq03.Font.Color := LColor;
  lbLinkMistral01.Font.Color := LColor;
  lbLinkMistral02.Font.Color := LColor;
  lbLinkMistral03.Font.Color := LColor;
  lbRestoreDefaults.Font.Color := LColor;
  lbLinkOllama01.Font.Color := LColor;
  lbLinkOllama02.Font.Color := LColor;
  lbLinkOllama03.Font.Color := LColor;
end;

procedure TDelphiAIDevSettingsView.btnApiKeyGeminiViewClick(Sender: TObject);
begin
  TUtils.TogglePasswordChar(edtApiKeyGemini);
end;

procedure TDelphiAIDevSettingsView.btnApiKeyOpenAIViewClick(Sender: TObject);
begin
  TUtils.TogglePasswordChar(edtApiKeyOpenAI);
end;

procedure TDelphiAIDevSettingsView.btnApiKeyGroqViewClick(Sender: TObject);
begin
  TUtils.TogglePasswordChar(edtApiKeyGroq);
end;

procedure TDelphiAIDevSettingsView.btnApiKeyMistralViewClick(Sender: TObject);
begin
  TUtils.TogglePasswordChar(edtApiKeyMistral);
end;

procedure TDelphiAIDevSettingsView.btnCloseClick(Sender: TObject);
begin
  Self.Close;
  Self.ModalResult := mrCancel;
end;

procedure TDelphiAIDevSettingsView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F4:
      if ssAlt in Shift then
        Key := 0;
    VK_ESCAPE:
      if Shift = [] then
        btnClose.Click;
  end;
end;

procedure TDelphiAIDevSettingsView.lbLinkGpt01Click(Sender: TObject);
begin
  //**Several
  TUtils.OpenLink(TLabel(Sender).Hint.Trim);
end;

procedure TDelphiAIDevSettingsView.lbRestoreDefaultsClick(Sender: TObject);
var
  LApiKeyGemini: string;
  LApiKeyOpenAI: string;
  LApiKeyGroq: string;
  LApiKeyMistral: string;
  LApiKeyOllama: string;
begin
  LApiKeyGemini := FSettings.ApiKeyGemini;
  LApiKeyOpenAI := FSettings.ApiKeyOpenAI;
  LApiKeyGroq := FSettings.ApiKeyGroq;
  LApiKeyMistral := FSettings.ApiKeyMistral;
  LApiKeyOllama := FSettings.ApiKeyOllama;

  FSettings.LoadDefaults;

  FSettings.ApiKeyGemini := LApiKeyGemini;
  FSettings.ApiKeyOpenAI := LApiKeyOpenAI;
  FSettings.ApiKeyGroq := LApiKeyGroq;
  FSettings.ApiKeyMistral := LApiKeyMistral;
  FSettings.ApiKeyOllama := LApiKeyOllama;

  Self.LoadSettings;
end;

procedure TDelphiAIDevSettingsView.btnConfirmClick(Sender: TObject);
begin
  Self.ValidateCodeCompletionShortcutInvoke;

  Self.SaveSettings;
  Self.Close;
  Self.ModalResult := mrOk;
end;

procedure TDelphiAIDevSettingsView.ValidateCodeCompletionShortcutInvoke;
var
  LShortcutStr: string;
  LShortCut: TShortCut;
begin
  LShortcutStr := Trim(edtCodeCompletionShortcutInvoke.Text);
  if LShortcutStr.Length = 1 then
    raise Exception.Create('Invalid CodeCompletion shortcut');

  LShortCut := TextToShortCut(LShortcutStr);

  if ShortCutToText(LShortCut).Trim.IsEmpty then
    edtCodeCompletionShortcutInvoke.Text := TConsts.CODE_COMPLETION_SHORTCUT_INVOKE;
end;

procedure TDelphiAIDevSettingsView.ckCodeCompletionSuggestionColorUseClick(Sender: TObject);
begin
  Self.ConfigFieldsCodeCompletionSuggestionColor;
end;

procedure TDelphiAIDevSettingsView.ConfigFieldsCodeCompletionSuggestionColor;
begin
  ColorBoxCodeCompletionSuggestionColor.Enabled := ckCodeCompletionSuggestionColorUse.Checked;
end;

procedure TDelphiAIDevSettingsView.ckColorHighlightCodeDelphiUseClick(Sender: TObject);
begin
  Self.ConfigFieldsColorHighlightDelphi;
end;

procedure TDelphiAIDevSettingsView.ConfigFieldsColorHighlightDelphi;
begin
  ColorBoxColorHighlightCodeDelphi.Enabled := ckColorHighlightCodeDelphiUse.Checked;
end;

procedure TDelphiAIDevSettingsView.LoadSettings;
begin
  cBoxLanguageQuestions.ItemIndex := Integer(FSettings.LanguageQuestions);
  cBoxAIDefault.ItemIndex := Integer(FSettings.AIDefault);

  ckColorHighlightCodeDelphiUse.Checked := FSettings.ColorHighlightCodeDelphiUse;
  ColorBoxColorHighlightCodeDelphi.Selected := FSettings.ColorHighlightCodeDelphi;
  Self.ConfigFieldsColorHighlightDelphi;
  mmDefaultPrompt.Lines.Text := FSettings.DefaultPrompt;

  ckCodeCompletionUse.Checked := FSettings.CodeCompletionUse;
  cBoxCodeCompletionAIDefault.ItemIndex := Integer(FSettings.CodeCompletionAIDefault);
  ckCodeCompletionSuggestionColorUse.Checked := FSettings.CodeCompletionSuggestionColorUse;
  ColorBoxCodeCompletionSuggestionColor.Selected := FSettings.CodeCompletionSuggestionColor;
  edtCodeCompletionShortcutInvoke.Text := FSettings.CodeCompletionShortcutInvoke;
  mmCodeCompletionDefaultPrompt.Lines.Text := FSettings.CodeCompletionDefaultPrompt;

  edtBaseUrlGemini.Text := FSettings.BaseUrlGemini;
  cBoxModelGemini.ItemIndex := cBoxModelGemini.Items.IndexOf(FSettings.ModelGemini);
  if cBoxModelGemini.ItemIndex < 0 then
    cBoxModelGemini.Text := FSettings.ModelGemini;
  edtApiKeyGemini.Text := FSettings.ApiKeyGemini;

  edtBaseUrlOpenAI.Text := FSettings.BaseUrlOpenAI;
  cBoxModelOpenAI.ItemIndex := cBoxModelOpenAI.Items.IndexOf(FSettings.ModelOpenAI);
  if cBoxModelOpenAI.ItemIndex < 0 then
    cBoxModelOpenAI.Text := FSettings.ModelOpenAI;
  edtApiKeyOpenAI.Text := FSettings.ApiKeyOpenAI;

  edtBaseUrlGroq.Text := FSettings.BaseUrlGroq;
  cBoxModelGroq.ItemIndex := cBoxModelGroq.Items.IndexOf(FSettings.ModelGroq);
  if cBoxModelGroq.ItemIndex < 0 then
    cBoxModelGroq.Text := FSettings.ModelGroq;
  edtApiKeyGroq.Text := FSettings.ApiKeyGroq;

  edtBaseUrlMistral.Text := FSettings.BaseUrlMistral;
  cBoxModelMistral.ItemIndex := cBoxModelMistral.Items.IndexOf(FSettings.ModelMistral);
  if cBoxModelMistral.ItemIndex < 0 then
    cBoxModelMistral.Text := FSettings.ModelMistral;
  edtApiKeyMistral.Text := FSettings.ApiKeyMistral;

  edtBaseUrlOllama.Text := FSettings.BaseUrlOllama;
  cBoxModelOllama.ItemIndex := cBoxModelOllama.Items.IndexOf(FSettings.ModelOllama);
  if cBoxModelOllama.ItemIndex < 0 then
    cBoxModelOllama.Text := FSettings.ModelOllama;
  edtApiKeyOllama.Text := FSettings.ApiKeyOllama;
end;

procedure TDelphiAIDevSettingsView.SaveSettings;
begin
  FSettings.LanguageQuestions := TC4DLanguage(cBoxLanguageQuestions.ItemIndex);
  FSettings.AIDefault := TC4DAiAvailable(cBoxAIDefault.ItemIndex);

  FSettings.ColorHighlightCodeDelphiUse := ckColorHighlightCodeDelphiUse.Checked;
  FSettings.ColorHighlightCodeDelphi := ColorBoxColorHighlightCodeDelphi.Selected;
  FSettings.DefaultPrompt := mmDefaultPrompt.Lines.Text;

  FSettings.CodeCompletionUse := ckCodeCompletionUse.Checked;
  FSettings.CodeCompletionAIDefault := TC4DAiAvailable(cBoxCodeCompletionAIDefault.ItemIndex);
  FSettings.CodeCompletionSuggestionColorUse := ckCodeCompletionSuggestionColorUse.Checked;
  FSettings.CodeCompletionSuggestionColor := ColorBoxCodeCompletionSuggestionColor.Selected;
  FSettings.CodeCompletionShortcutInvoke := edtCodeCompletionShortcutInvoke.Text;
  FSettings.CodeCompletionDefaultPrompt := mmCodeCompletionDefaultPrompt.Lines.Text;

  FSettings.BaseUrlGemini := edtBaseUrlGemini.Text;
  FSettings.ModelGemini := cBoxModelGemini.Text;
  FSettings.ApiKeyGemini := edtApiKeyGemini.Text;

  FSettings.BaseUrlOpenAI := edtBaseUrlOpenAI.Text;
  FSettings.ModelOpenAI := cBoxModelOpenAI.Text;
  FSettings.ApiKeyOpenAI := edtApiKeyOpenAI.Text;

  FSettings.BaseUrlGroq := edtBaseUrlGroq.Text;
  FSettings.ModelGroq := cBoxModelGroq.Text;
  FSettings.ApiKeyGroq := edtApiKeyGroq.Text;

  FSettings.BaseUrlMistral := edtBaseUrlMistral.Text;
  FSettings.ModelMistral := cBoxModelMistral.Text;
  FSettings.ApiKeyMistral := edtApiKeyMistral.Text;

  FSettings.BaseUrlOllama := edtBaseUrlOllama.Text;
  FSettings.ModelOllama := cBoxModelOllama.Text;
  FSettings.ApiKeyOllama := edtApiKeyOllama.Text;

  FSettings.SaveData;
end;

procedure TDelphiAIDevSettingsView.btnApiKeyOllamaViewClick(Sender: TObject);
begin
  TUtils.TogglePasswordChar(edtApiKeyOllama);
end;

procedure TDelphiAIDevSettingsView.PanelsSetParent;
begin
  pnPreferencesBack.Visible := False;
  pnIAsOnLineBack.Visible := False;
  pnIAsOffLineBack.Visible := False;
  pnCodeCompletionBack.Visible := False;

  pnPreferencesBack.Parent := pnBody;
  pnIAsOnLineBack.Parent := pnBody;
  pnIAsOffLineBack.Parent := pnBody;
  pnCodeCompletionBack.Parent := pnBody;
  PageControl1.Visible := False;

  btnPreferences.Click;
end;

procedure TDelphiAIDevSettingsView.btnPreferencesClick(Sender: TObject);
begin
  Self.ShowPanel(TButton(Sender), pnPreferencesBack);
end;

procedure TDelphiAIDevSettingsView.btnIAsOnlineClick(Sender: TObject);
begin
  Self.ShowPanel(TButton(Sender), pnIAsOnLineBack);
end;

procedure TDelphiAIDevSettingsView.btnOpenDataFolderClick(Sender: TObject);
var
  LPathFolder: string;
begin
  LPathFolder := TUtils.GetPathFolderRoot;
  if not DirectoryExists(LPathFolder) then
    TUtils.ShowMsg('Forder not found: ' + LPathFolder);

  TUtils.OpenFolder(LPathFolder);
end;

procedure TDelphiAIDevSettingsView.btnIAsOfflineClick(Sender: TObject);
begin
  Self.ShowPanel(TButton(Sender), pnIAsOffLineBack);
end;

procedure TDelphiAIDevSettingsView.btnCodeCompletionClick(Sender: TObject);
begin
  Self.ShowPanel(TButton(Sender), pnCodeCompletionBack);
end;

procedure TDelphiAIDevSettingsView.ShowPanel(const AButton: TButton; const APanel: TPanel);
begin
  btnPreferences.Default := False;
  btnIAsOnline.Default := False;
  btnIAsOffline.Default := False;
  btnCodeCompletion.Default := False;
  AButton.Default := True;

  pnPreferencesBack.Visible := False;
  pnIAsOnLineBack.Visible := False;
  pnIAsOffLineBack.Visible := False;
  pnCodeCompletionBack.Visible := False;
  APanel.Visible := True;
end;

end.
