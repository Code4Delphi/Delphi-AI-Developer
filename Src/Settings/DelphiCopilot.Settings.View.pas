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
  DelphiCopilot.Types;

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
    Label9: TLabel;
    edtBaseUrlGemini: TEdit;
    edtApiKeyGemini: TEdit;
    cBoxModelGemini: TComboBox;
    edtTimeoutGemini: TEdit;
    Label10: TLabel;
    GroupBox2: TGroupBox;
    gBoxOpenAI: TGroupBox;
    pnOpenAIBack: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    lbGenerateAPIKey: TLabel;
    edtBaseUrlOpenAI: TEdit;
    edtApiKeyOpenAI: TEdit;
    cBoxModelOpenAI: TComboBox;
    edtTimeoutOpenAi: TEdit;
    Label11: TLabel;
    cBoxAIDefault: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure lbGenerateAPIKeyClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
  private
    FSettings: TDelphiCopilotSettings;
    procedure SaveSettings;
    procedure LoadSettings;
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
  TDelphiCopilotUtilsOTA.IDEThemingAll(TDelphiCopilotSettingsView, Self);
  FSettings := TDelphiCopilotSettings.Create;
end;

procedure TDelphiCopilotSettingsView.FormDestroy(Sender: TObject);
begin
  FSettings.Free;
end;

procedure TDelphiCopilotSettingsView.FormShow(Sender: TObject);
begin
  Self.LoadSettings;
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

procedure TDelphiCopilotSettingsView.lbGenerateAPIKeyClick(Sender: TObject);
begin
  //**Several
  TDelphiCopilotUtils.OpenLink(TLabel(Sender).Hint.Trim);
end;

procedure TDelphiCopilotSettingsView.LoadSettings;
begin
  FSettings.ReadFromWindowsRegistry;
  cBoxAIDefault.ItemIndex := Integer(FSettings.AIDefault);

  edtBaseUrlGemini.Text := FSettings.BaseUrlGemini;
  cBoxModelGemini.Text := FSettings.ModelGemini;
  edtApiKeyGemini.Text := FSettings.ApiKeyGemini;
  edtTimeoutGemini.Text := FSettings.TimeoutGemini.ToString;

  edtBaseUrlOpenAI.Text := FSettings.BaseUrlOpenAI;
  cBoxModelOpenAI.Text := FSettings.ModelOpenAI;
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

  FSettings.WriteToWindowsRegistry;
end;

procedure TDelphiCopilotSettingsView.btnConfirmClick(Sender: TObject);
begin
  Self.SaveSettings;
  Self.Close;
  Self.ModalResult := mrOk;
end;

end.
