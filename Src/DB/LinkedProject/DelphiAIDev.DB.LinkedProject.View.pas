unit DelphiAIDev.DB.LinkedProject.View;

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
  TDelphiAIDevDBLinkedProjectView = class(TForm)
    Bevel2: TBevel;
    pnBody: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    lbLastGeneration: TLabel;
    pnButtons: TPanel;
    btnSaveLink: TButton;
    btnClose: TButton;
    cBoxDatabases: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveLinkClick(Sender: TObject);
    procedure cBoxDatabasesClick(Sender: TObject);
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

procedure TDelphiAIDevDBLinkedProjectView.FormCreate(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
  TUtilsOTA.IDEThemingAll(TDelphiAIDevDBLinkedProjectView, Self);
end;

procedure TDelphiAIDevDBLinkedProjectView.FormDestroy(Sender: TObject);
begin
  //FProjectsFields.Free;
end;

procedure TDelphiAIDevDBLinkedProjectView.FormShow(Sender: TObject);
begin
  FProjectsFields := TDelphiAIDevProjectsModel.New.ReadFilePath(FOTAProject.FileName);

  Self.FillScreenFields;
end;

procedure TDelphiAIDevDBLinkedProjectView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FProjectsFields)then
    FProjectsFields.Free;
end;

procedure TDelphiAIDevDBLinkedProjectView.FillScreenFields;
begin
  Screen.Cursor := crHourGlass;
  try
    Self.FillcBoxDatabases;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TDelphiAIDevDBLinkedProjectView.FillcBoxDatabases;
var
  LDBRegistersFields: TDelphiAIDevDBRegistersFields;
begin
  TDelphiAIDevDBUtils.FillComboBoxDataBases(cBoxDatabases);

  LDBRegistersFields := TDelphiAIDevDBRegistersModel.New.Re

//  if not FProjectsFields.GuidDatabaseDefault.Trim.IsEmpty then
//    cBoxDatabases.ItemIndex := cBoxDatabases.Items.IndexOf(FProjectsFields);

  Self.FillDateLastReferences;
end;

procedure TDelphiAIDevDBLinkedProjectView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TDelphiAIDevDBLinkedProjectView.cBoxDatabasesClick(Sender: TObject);
begin
  Self.FillDateLastReferences;
end;

procedure TDelphiAIDevDBLinkedProjectView.FillDateLastReferences;
begin
  lbLastGeneration.Caption := '';

  if cBoxDatabases.Items.Count < 0 then
    Exit;

  lbLastGeneration.Caption := TUtils.DateTimeToStrEmpty(Self.GetFieldDBSelected.LastReferences);
end;

function TDelphiAIDevDBLinkedProjectView.GetFieldDBSelected: TDelphiAIDevDBRegistersFields;
begin
  Result := TDelphiAIDevDBRegistersFields(cBoxDatabases.Items.Objects[cBoxDatabases.ItemIndex]);
end;

procedure TDelphiAIDevDBLinkedProjectView.btnCloseClick(Sender: TObject);
begin
  Self.Close;
  Self.ModalResult := mrCancel;
end;

procedure TDelphiAIDevDBLinkedProjectView.btnSaveLinkClick(Sender: TObject);
begin
  Self.ValidateFillingFields;

  Screen.Cursor := crHourGlass;
  try
    FProjectsFields.FilePath := FOTAProject.FileName;
    FProjectsFields.GuidDatabaseDefault := Self.GetFieldDBSelected.Guid;

    TDelphiAIDevProjectsModel.New.SaveOrEditData(FProjectsFields);
  finally
    Screen.Cursor := crDefault;
  end;

  Self.Close;
  Self.ModalResult := mrOk;
end;

procedure TDelphiAIDevDBLinkedProjectView.ValidateFillingFields;
begin
  if cBoxDatabases.ItemIndex < 0 then
    TUtils.ShowMsgAndAbort('No informed Database', cBoxDatabases);
end;

end.
