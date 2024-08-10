unit DelphiAIDev.Databases.AddEdit.View;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Menus,
  Vcl.ComCtrls,
  DelphiAIDev.Types,
  DelphiAIDev.Databases.Fields;

type
  TDelphiAIDevDatabasesAddEditView = class(TForm)
    Panel1: TPanel;
    btnConfirm: TButton;
    btnClose: TButton;
    Panel9: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label2: TLabel;
    cBoxDriverID: TComboBox;
    Label3: TLabel;
    edtDescription: TEdit;
    Label1: TLabel;
    edtHost: TEdit;
    Label5: TLabel;
    edtUser: TEdit;
    Label6: TLabel;
    edtPassword: TEdit;
    Label7: TLabel;
    edtPort: TEdit;
    Label4: TLabel;
    edtDatabase: TEdit;
    Label8: TLabel;
    edtVendorLib: TEdit;
    ckVisible: TCheckBox;
    lbAddLocalDatabase: TLabel;
    Button1: TButton;
    btnTestConnection: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbAddLocalDatabaseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnTestConnectionClick(Sender: TObject);
  private
    FFields: TDelphiAIDevDatabasesFields;
    procedure FillcBoxDriverID;
    procedure FillScreenFields;
  public
    property Fields: TDelphiAIDevDatabasesFields read FFields write FFields;
  end;

implementation

uses
  DelphiAIDev.Consts,
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA,
  DelphiAIDev.DataBases.Model;

{$R *.dfm}

procedure TDelphiAIDevDatabasesAddEditView.FillcBoxDriverID;
begin
  cBoxDriverID.Items.Clear;
  TUtils.DriverIDFillItemsTStrings(cBoxDriverID.Items);
end;

procedure TDelphiAIDevDatabasesAddEditView.FormCreate(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
  TUtilsOTA.IDEThemingAll(TDelphiAIDevDatabasesAddEditView, Self);
  Self.FillcBoxDriverID;
end;

procedure TDelphiAIDevDatabasesAddEditView.FormShow(Sender: TObject);
begin
  Self.FillScreenFields;
  edtDescription.SetFocus
end;

procedure TDelphiAIDevDatabasesAddEditView.lbAddLocalDatabaseClick(Sender: TObject);
begin
  edtHost.Text := 'localhost';
end;

procedure TDelphiAIDevDatabasesAddEditView.FillScreenFields;
begin
  cBoxDriverID.ItemIndex := cBoxDriverID.Items.IndexOf(FFields.DriverID.ToString);
  edtDescription.Text := FFields.Description;
  edtHost.Text := FFields.Host;
  edtUser.Text := FFields.User;
  edtPassword.Text := FFields.Password;
  edtPort.Text := FFields.Port.ToString;
  edtDatabase.Text := FFields.DatabaseName;
  edtVendorLib.Text := FFields.VendorLib;
  ckVisible.Checked := FFields.Visible;
end;

procedure TDelphiAIDevDatabasesAddEditView.btnCloseClick(Sender: TObject);
begin
  Self.Close;
  Self.ModalResult := mrCancel;
end;

procedure TDelphiAIDevDatabasesAddEditView.btnConfirmClick(Sender: TObject);
begin
  if cBoxDriverID.ItemIndex < 0 then
    TUtils.ShowMsgAndAbort('No informed Driver ID', cBoxDriverID);

  if TUtils.StrToDriverID(cBoxDriverID.Text) = TC4DDriverID.None then
    TUtils.ShowMsgAndAbort('Select a DriverID', cBoxDriverID);

  if Trim(edtDescription.Text).IsEmpty then
    TUtils.ShowMsgAndAbort('No informed Description', edtDescription);

  if Trim(edtHost.Text).IsEmpty then
    TUtils.ShowMsgAndAbort('No informed Host', edtHost);

  if Trim(edtUser.Text).IsEmpty then
    TUtils.ShowMsgAndAbort('No informed User', edtUser);

  if Trim(edtDatabase.Text).IsEmpty then
    TUtils.ShowMsgAndAbort('No informed Database', edtDatabase);

  FFields.DriverID := TUtils.StrToDriverID(cBoxDriverID.Text);
  FFields.Description := edtDescription.Text;
  FFields.Host := edtHost.Text;
  FFields.User := edtUser.Text;
  FFields.Password := edtPassword.Text;
  FFields.Port := StrToIntDef(edtPort.Text, 0);
  FFields.DatabaseName := edtDatabase.Text;
  FFields.VendorLib := edtVendorLib.Text;
  FFields.Visible := ckVisible.Checked;

  TDelphiAIDevDatabasesModel.New.SaveOrEditData(FFields);

  Self.Close;
  Self.ModalResult := mrOK;
end;

procedure TDelphiAIDevDatabasesAddEditView.Button1Click(Sender: TObject);
begin
  if edtPassword.PasswordChar = '*' then
    edtPassword.PasswordChar := #0
  else
    edtPassword.PasswordChar := '*';
end;

procedure TDelphiAIDevDatabasesAddEditView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TDelphiAIDevDatabasesAddEditView.btnTestConnectionClick(Sender: TObject);
begin
  //
end;

end.
