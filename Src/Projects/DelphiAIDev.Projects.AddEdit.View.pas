unit DelphiAIDev.Projects.AddEdit.View;

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
  ToolsAPI,
  DelphiAIDev.DB.Registers.Model,
  DelphiAIDev.DB.Registers.Fields,
  DelphiAIDev.Projects.Model,
  DelphiAIDev.Projects.Fields;

type
  TDelphiAIDevProjectsAddEditView = class(TForm)
    Bevel2: TBevel;
    pnBody: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    lbLastGeneration: TLabel;
    pnButtons: TPanel;
    btnConfirm: TButton;
    btnClose: TButton;
    cBoxDatabaseDefault: TComboBox;
    Label2: TLabel;
    edtNickname: TEdit;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure cBoxDatabaseDefaultClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FOTAProject: IOTAProject;
    FProjectsFields: TDelphiAIDevProjectsFields;
    procedure FillScreenFields;
    procedure FillcBoxDatabases;
    procedure FillDateLastReferences;
    function GetFieldDBSelected: TDelphiAIDevDBRegistersFields;
    procedure ValidateFillingFields;
  public
    property OTAProject: IOTAProject write FOTAProject;
  end;

implementation

uses
  DelphiAIDev.Consts,
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA,
  DelphiAIDev.DB.Utils;

{$R *.dfm}

procedure TDelphiAIDevProjectsAddEditView.FormCreate(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
  TUtilsOTA.IDEThemingAll(TDelphiAIDevProjectsAddEditView, Self);
end;

procedure TDelphiAIDevProjectsAddEditView.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TDelphiAIDevProjectsAddEditView.FormShow(Sender: TObject);
begin
  FProjectsFields := TDelphiAIDevProjectsModel.New.ReadFilePath(FOTAProject.FileName);
  Self.FillScreenFields;
end;

procedure TDelphiAIDevProjectsAddEditView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FProjectsFields)then
    FProjectsFields.Free;
end;

procedure TDelphiAIDevProjectsAddEditView.FillScreenFields;
begin
  Screen.Cursor := crHourGlass;
  try
    edtNickname.Text := FProjectsFields.Nickname;
    Self.FillcBoxDatabases;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TDelphiAIDevProjectsAddEditView.FillcBoxDatabases;
begin
  TDelphiAIDevDBUtils.FillComboBoxDataBases(cBoxDatabaseDefault, FProjectsFields.GuidDatabaseDefault);
  Self.FillDateLastReferences;
end;

procedure TDelphiAIDevProjectsAddEditView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TDelphiAIDevProjectsAddEditView.cBoxDatabaseDefaultClick(Sender: TObject);
begin
  Self.FillDateLastReferences;
end;

procedure TDelphiAIDevProjectsAddEditView.FillDateLastReferences;
begin
  lbLastGeneration.Caption := '';

  if cBoxDatabaseDefault.Items.Count < 0 then
    Exit;

  lbLastGeneration.Caption := TUtils.DateTimeToStrEmpty(Self.GetFieldDBSelected.LastReferences);
end;

function TDelphiAIDevProjectsAddEditView.GetFieldDBSelected: TDelphiAIDevDBRegistersFields;
begin
  Result := TDelphiAIDevDBRegistersFields(cBoxDatabaseDefault.Items.Objects[cBoxDatabaseDefault.ItemIndex]);
end;

procedure TDelphiAIDevProjectsAddEditView.btnCloseClick(Sender: TObject);
begin
  Self.Close;
  Self.ModalResult := mrCancel;
end;

procedure TDelphiAIDevProjectsAddEditView.btnConfirmClick(Sender: TObject);
begin
  Self.ValidateFillingFields;

  Screen.Cursor := crHourGlass;
  try
    FProjectsFields.FilePath := FOTAProject.FileName;
    FProjectsFields.Nickname := edtNickname.Text;
    FProjectsFields.GuidDatabaseDefault := Self.GetFieldDBSelected.Guid;

    TDelphiAIDevProjectsModel.New.SaveOrEditData(FProjectsFields);
  finally
    Screen.Cursor := crDefault;
  end;

  Self.Close;
  Self.ModalResult := mrOk;
end;

procedure TDelphiAIDevProjectsAddEditView.ValidateFillingFields;
begin
  if Trim(edtNickname.Text).IsEmpty then
    TUtils.ShowMsgAndAbort('No informed Nickname', edtNickname);

//  if cBoxDatabaseDefault.ItemIndex < 0 then
//    TUtils.ShowMsgAndAbort('No informed Database', cBoxDatabaseDefault);
end;

end.
