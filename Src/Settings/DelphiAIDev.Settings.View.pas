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
  DelphiAIDev.Settings,
  DelphiAIDev.Types,
  Vcl.Buttons, Vcl.ComCtrls;

type
  TDelphiAIDevSettingsView = class(TForm)
    pnBottom: TPanel;
    btnConfirm: TButton;
    btnClose: TButton;
    pnBackAll: TPanel;
    pnBody: TPanel;
    gBoxGemini: TGroupBox;
    pnGeminiBack: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lbLinkGemini01: TLabel;
    edtBaseUrlGemini: TEdit;
    edtApiKeyGemini: TEdit;
    cBoxModelGemini: TComboBox;
    lbLinkGemini02: TLabel;
    GroupBox2: TGroupBox;
    gBoxOpenAI: TGroupBox;
    pnOpenAIBack: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    lbLinkGpt01: TLabel;
    edtBaseUrlOpenAI: TEdit;
    edtApiKeyOpenAI: TEdit;
    cBoxModelOpenAI: TComboBox;
    Label11: TLabel;
    cBoxAIDefault: TComboBox;
    btnApiKeyGeminiView: TSpeedButton;
    btnApiKeyOpenAIView: TSpeedButton;
    lbLinkGpt02: TLabel;
    lbRestoreDefaults: TLabel;
    ColorBoxColorHighlightCodeDelphi: TColorBox;
    ckColorHighlightCodeDelphiUse: TCheckBox;
    lbLinkGemini03: TLabel;
    Label4: TLabel;
    cBoxLanguageQuestions: TComboBox;
    gBoxGroq: TGroupBox;
    pnGroqBack: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    lbLinkGroq01: TLabel;
    btnApiKeyGroqView: TSpeedButton;
    lbLinkGroq02: TLabel;
    edtBaseUrlGroq: TEdit;
    edtApiKeyGroq: TEdit;
    cBoxModelGroq: TComboBox;
    lbLinkGroq03: TLabel;
    lbOpenDataFolder: TLabel;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    btnApiKeyOllamaView: TSpeedButton;
    lbLinkOllama01: TLabel;
    lbLinkOllama02: TLabel;
    lbLinkOllama03: TLabel;
    edtBaseUrlOllama: TEdit;
    edtApiKeyOllama: TEdit;
    cBoxModelOllama: TComboBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
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
    procedure lbOpenDataFolderClick(Sender: TObject);
    procedure btnApiKeyOllamaViewClick(Sender: TObject);
  private
    FSettings: TDelphiAIDevSettings;
    procedure SaveSettings;
    procedure LoadSettings;
    procedure ConfigScreen;
    procedure ConfigFieldsColorHighlightDelphi;
    procedure FillcBoxLanguageQuestions;
    procedure FillcBoxAIDefault;
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

  Self.FillcBoxLanguageQuestions;
  Self.FillcBoxAIDefault;
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
  LItem: TC4DAIsAvailable;
begin
  cBoxAIDefault.Items.Clear;
  for LItem := Low(TC4DAIsAvailable) to High(TC4DAIsAvailable) do
    cBoxAIDefault.Items.Add(LItem.ToString);
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
  lbRestoreDefaults.Font.Color := LColor;
  lbOpenDataFolder.Font.Color := LColor;
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
  LApiKeyOllama: string;
begin
  LApiKeyGemini := FSettings.ApiKeyGemini;
  LApiKeyOpenAI := FSettings.ApiKeyOpenAI;
  LApiKeyGroq := FSettings.ApiKeyGroq;
  LApiKeyOllama := FSettings.ApiKeyOllama;

  FSettings.LoadDefaults;

  FSettings.ApiKeyGemini := LApiKeyGemini;
  FSettings.ApiKeyOpenAI := LApiKeyOpenAI;
  FSettings.ApiKeyGroq := LApiKeyGroq;
  FSettings.ApiKeyOllama := LApiKeyOllama;

  Self.LoadSettings;
end;

procedure TDelphiAIDevSettingsView.btnConfirmClick(Sender: TObject);
begin
  Self.SaveSettings;
  Self.Close;
  Self.ModalResult := mrOk;
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

  edtBaseUrlOllama.Text := FSettings.BaseUrlOllama;
  cBoxModelOllama.ItemIndex := cBoxModelOllama.Items.IndexOf(FSettings.ModelOllama);
  if cBoxModelOllama.ItemIndex < 0 then
    cBoxModelOllama.Text := FSettings.ModelOllama;
  edtApiKeyOllama.Text := FSettings.ApiKeyOllama;
end;

procedure TDelphiAIDevSettingsView.SaveSettings;
begin
  FSettings.LanguageQuestions := TC4DLanguage(cBoxLanguageQuestions.ItemIndex);
  FSettings.AIDefault := TC4DAIsAvailable(cBoxAIDefault.ItemIndex);

  FSettings.ColorHighlightCodeDelphiUse := ckColorHighlightCodeDelphiUse.Checked;
  FSettings.ColorHighlightCodeDelphi := ColorBoxColorHighlightCodeDelphi.Selected;

  FSettings.BaseUrlGemini := edtBaseUrlGemini.Text;
  FSettings.ModelGemini := cBoxModelGemini.Text;
  FSettings.ApiKeyGemini := edtApiKeyGemini.Text;

  FSettings.BaseUrlOpenAI := edtBaseUrlOpenAI.Text;
  FSettings.ModelOpenAI := cBoxModelOpenAI.Text;
  FSettings.ApiKeyOpenAI := edtApiKeyOpenAI.Text;

  FSettings.BaseUrlGroq := edtBaseUrlGroq.Text;
  FSettings.ModelGroq := cBoxModelGroq.Text;
  FSettings.ApiKeyGroq := edtApiKeyGroq.Text;

  FSettings.BaseUrlOllama := edtBaseUrlOllama.Text;
  FSettings.ModelOllama := cBoxModelOllama.Text;
  FSettings.ApiKeyOllama := edtApiKeyOllama.Text;

  FSettings.SaveData;
end;

procedure TDelphiAIDevSettingsView.lbOpenDataFolderClick(Sender: TObject);
var
  LPathFolder: string;
begin
  LPathFolder := TUtils.GetPathFolderRoot;
  if not DirectoryExists(LPathFolder) then
    TUtils.ShowMsg('Forder not found: ' + LPathFolder);

  TUtils.OpenFolder(LPathFolder);
end;

procedure TDelphiAIDevSettingsView.btnApiKeyOllamaViewClick(Sender: TObject);
begin
  TUtils.TogglePasswordChar(edtApiKeyOllama);
end;

end.
