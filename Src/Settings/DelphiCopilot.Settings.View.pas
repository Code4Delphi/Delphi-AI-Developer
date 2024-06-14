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
  DelphiCopilot.Types, Vcl.Buttons;

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
    Label8: TLabel;
    lbLink01: TLabel;
    edtBaseUrlGemini: TEdit;
    edtApiKeyGemini: TEdit;
    cBoxModelGemini: TComboBox;
    edtTimeoutGemini: TEdit;
    lbLink02: TLabel;
    GroupBox2: TGroupBox;
    gBoxOpenAI: TGroupBox;
    pnOpenAIBack: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    lbLink03: TLabel;
    edtBaseUrlOpenAI: TEdit;
    edtApiKeyOpenAI: TEdit;
    cBoxModelOpenAI: TComboBox;
    edtTimeoutOpenAi: TEdit;
    Label11: TLabel;
    cBoxAIDefault: TComboBox;
    btnApiKeyGeminiView: TSpeedButton;
    btnApiKeyOpenAIView: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure lbLink03Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure btnApiKeyGeminiViewClick(Sender: TObject);
    procedure btnApiKeyOpenAIViewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FSettings: TDelphiCopilotSettings;
    procedure SaveSettings;
    procedure LoadSettings;
    procedure ConfigScreen;
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

procedure TDelphiCopilotSettingsView.btnConfirmClick(Sender: TObject);
begin
  Self.SaveSettings;
  Self.Close;
  Self.ModalResult := mrOk;
end;

procedure TDelphiCopilotSettingsView.LoadSettings;
begin
  FSettings.LoadData;
  cBoxAIDefault.ItemIndex := Integer(FSettings.AIDefault);

  edtBaseUrlGemini.Text := FSettings.BaseUrlGemini;
  cBoxModelGemini.ItemIndex := cBoxModelGemini.Items.IndexOf(FSettings.ModelGemini);
  edtApiKeyGemini.Text := FSettings.ApiKeyGemini;
  edtTimeoutGemini.Text := FSettings.TimeoutGemini.ToString;

  edtBaseUrlOpenAI.Text := FSettings.BaseUrlOpenAI;
  cBoxModelOpenAI.ItemIndex := cBoxModelOpenAI.Items.IndexOf(FSettings.ModelOpenAI);
  edtApiKeyOpenAI.Text := FSettings.ApiKeyOpenAI;
  edtTimeoutOpenAI.Text := FSettings.TimeoutOpenAI.ToString;
end;

procedure TDelphiCopilotSettingsView.SaveSettings;
begin
  FSettings.AIDefault := TAIsAvailable(cBoxAIDefault.ItemIndex);

  FSettings.BaseUrlGemini := edtBaseUrlGemini.Text;
  FSettings.ModelGemini := cBoxModelGemini.Text;
  FSettings.ApiKeyGemini := edtApiKeyGemini.Text;
  FSettings.TimeoutGemini := StrToIntDef(edtTimeoutGemini.Text, 20);

  FSettings.BaseUrlOpenAI := edtBaseUrlOpenAI.Text;
  FSettings.ModelOpenAI := cBoxModelOpenAI.Text;
  FSettings.ApiKeyOpenAI := edtApiKeyOpenAI.Text;
  FSettings.TimeoutOpenAI := StrToIntDef(edtTimeoutOpenAI.Text, 20);

  FSettings.SaveData;
end;

end.
