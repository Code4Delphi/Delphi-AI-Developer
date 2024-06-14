unit DelphiCopilot.Settings.View;

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
  DelphiCopilot.Settings,
  DelphiCopilot.Types,
  Vcl.Buttons;

type
  TDelphiCopilotSettingsView = class(TForm)
    pnBottom: TPanel;
    btnConfirm: TButton;
    btnClose: TButton;
    pnlMain: TPanel;
    pnBody: TPanel;
    gBoxGemini: TGroupBox;
    pnGeminiBack: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lbLink01: TLabel;
    edtBaseUrlGemini: TEdit;
    edtApiKeyGemini: TEdit;
    cBoxModelGemini: TComboBox;
    lbLink02: TLabel;
    GroupBox2: TGroupBox;
    gBoxOpenAI: TGroupBox;
    pnOpenAIBack: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    lbLink03: TLabel;
    edtBaseUrlOpenAI: TEdit;
    edtApiKeyOpenAI: TEdit;
    cBoxModelOpenAI: TComboBox;
    Label11: TLabel;
    cBoxAIDefault: TComboBox;
    btnApiKeyGeminiView: TSpeedButton;
    btnApiKeyOpenAIView: TSpeedButton;
    lbLink04: TLabel;
    lbRestoreDefaults: TLabel;
    ColorBoxColorHighlightCodeDelphi: TColorBox;
    ckColorHighlightCodeDelphiUse: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure lbLink03Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure btnApiKeyGeminiViewClick(Sender: TObject);
    procedure btnApiKeyOpenAIViewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbRestoreDefaultsClick(Sender: TObject);
    procedure ckColorHighlightCodeDelphiUseClick(Sender: TObject);
  private
    FSettings: TDelphiCopilotSettings;
    procedure SaveSettings;
    procedure LoadSettings;
    procedure ConfigScreen;
    procedure ConfigFieldsColorHighlightDelphi;
  public

  end;

var
  DelphiCopilotSettingsView: TDelphiCopilotSettingsView;

implementation

uses
  DelphiCopilot.Utils,
  DelphiCopilot.Utils.OTA;

{$R *.dfm}

procedure TDelphiCopilotSettingsView.FormCreate(Sender: TObject);
begin
  TUtilsOTA.IDEThemingAll(TDelphiCopilotSettingsView, Self);
  FSettings := TDelphiCopilotSettings.GetInstance;
end;

procedure TDelphiCopilotSettingsView.FormShow(Sender: TObject);
begin
  FSettings.LoadData;
  Self.ConfigScreen;
  FSettings.LoadData;
  Self.LoadSettings;
end;

procedure TDelphiCopilotSettingsView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FSettings.LoadData;
end;

procedure TDelphiCopilotSettingsView.ConfigScreen;
begin
  lbLink01.Font.Color := TUtilsOTA.ActiveThemeColorLink;
  lbLink02.Font.Color := lbLink01.Font.Color;
  lbLink03.Font.Color := lbLink01.Font.Color;
  lbLink04.Font.Color := lbLink01.Font.Color;
  lbRestoreDefaults.Font.Color := lbLink01.Font.Color;
end;

procedure TDelphiCopilotSettingsView.btnApiKeyGeminiViewClick(Sender: TObject);
begin
  TUtils.TogglePasswordChar(edtApiKeyGemini);
end;

procedure TDelphiCopilotSettingsView.btnApiKeyOpenAIViewClick(Sender: TObject);
begin
  TUtils.TogglePasswordChar(edtApiKeyOpenAI);
end;

procedure TDelphiCopilotSettingsView.btnCloseClick(Sender: TObject);
begin
  Self.Close;
  Self.ModalResult := mrCancel;
end;

procedure TDelphiCopilotSettingsView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case(Key)of
    VK_F4:
      if(ssAlt in Shift)then
        Key := 0;
    VK_ESCAPE:
      if(Shift = [])then
        btnClose.Click;
  end;
end;

procedure TDelphiCopilotSettingsView.lbLink03Click(Sender: TObject);
begin
  //**Several
  TUtils.OpenLink(TLabel(Sender).Hint.Trim);
end;

procedure TDelphiCopilotSettingsView.lbRestoreDefaultsClick(Sender: TObject);
var
  LApiKeyGemini: string;
  LApiKeyOpenAI: string;
begin
  LApiKeyGemini := FSettings.ApiKeyGemini;
  LApiKeyOpenAI := FSettings.ApiKeyOpenAI;

  FSettings.LoadDefaults;

  FSettings.ApiKeyGemini := LApiKeyGemini;
  FSettings.ApiKeyOpenAI := LApiKeyOpenAI;

  Self.LoadSettings;
end;

procedure TDelphiCopilotSettingsView.btnConfirmClick(Sender: TObject);
begin
  Self.SaveSettings;
  Self.Close;
  Self.ModalResult := mrOk;
end;

procedure TDelphiCopilotSettingsView.ckColorHighlightCodeDelphiUseClick(Sender: TObject);
begin
  Self.ConfigFieldsColorHighlightDelphi;
end;

procedure TDelphiCopilotSettingsView.ConfigFieldsColorHighlightDelphi;
begin
  ColorBoxColorHighlightCodeDelphi.Enabled := ckColorHighlightCodeDelphiUse.Checked;
end;

procedure TDelphiCopilotSettingsView.LoadSettings;
begin
  cBoxAIDefault.ItemIndex := Integer(FSettings.AIDefault);

  ckColorHighlightCodeDelphiUse.Checked := FSettings.ColorHighlightCodeDelphiUse;
  ColorBoxColorHighlightCodeDelphi.Selected := FSettings.ColorHighlightCodeDelphi;
  Self.ConfigFieldsColorHighlightDelphi;

  edtBaseUrlGemini.Text := FSettings.BaseUrlGemini;
  cBoxModelGemini.ItemIndex := cBoxModelGemini.Items.IndexOf(FSettings.ModelGemini);
  edtApiKeyGemini.Text := FSettings.ApiKeyGemini;

  edtBaseUrlOpenAI.Text := FSettings.BaseUrlOpenAI;
  cBoxModelOpenAI.ItemIndex := cBoxModelOpenAI.Items.IndexOf(FSettings.ModelOpenAI);
  edtApiKeyOpenAI.Text := FSettings.ApiKeyOpenAI;
end;

procedure TDelphiCopilotSettingsView.SaveSettings;
begin
  FSettings.AIDefault := TAIsAvailable(cBoxAIDefault.ItemIndex);

  FSettings.ColorHighlightCodeDelphiUse := ckColorHighlightCodeDelphiUse.Checked;
  FSettings.ColorHighlightCodeDelphi := ColorBoxColorHighlightCodeDelphi.Selected;

  FSettings.BaseUrlGemini := edtBaseUrlGemini.Text;
  FSettings.ModelGemini := cBoxModelGemini.Text;
  FSettings.ApiKeyGemini := edtApiKeyGemini.Text;

  FSettings.BaseUrlOpenAI := edtBaseUrlOpenAI.Text;
  FSettings.ModelOpenAI := cBoxModelOpenAI.Text;
  FSettings.ApiKeyOpenAI := edtApiKeyOpenAI.Text;

  FSettings.SaveData;
end;

end.
