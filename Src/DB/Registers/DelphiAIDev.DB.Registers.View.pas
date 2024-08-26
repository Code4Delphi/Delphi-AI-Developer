unit DelphiAIDev.DB.Registers.View;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  C4D.Conn,
  DelphiAIDev.Utils.ListView,
  DelphiAIDev.DB.Registers.Model,
  DelphiAIDev.DB.Registers.Fields,
  DelphiAIDev.DB.Registers.AddEdit.View,
  DelphiAIDev.DB.References.View;

type
  TDelphiAIDevDBRegistersView = class(TForm)
    Panel1: TPanel;
    btnEdit: TButton;
    btnClose: TButton;
    ListView: TListView;
    pnTop: TPanel;
    btnSearch: TButton;
    edtSearch: TEdit;
    StatusBar1: TStatusBar;
    btnAdd: TButton;
    btnRemove: TButton;
    btnGenerateDatabaseReference: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure ListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure ListViewDblClick(Sender: TObject);
    procedure ListViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnEditClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListViewColumnClick(Sender: TObject; Column: TListColumn);
    procedure btnGenerateDatabaseReferenceClick(Sender: TObject);
  private
    FUtilsListView: IDelphiAIDevUtilsListView;
    FMadeChanges: Boolean;
    procedure ReloadData;
    procedure ReloadDataInternal;
    procedure FillStatusBar(AItem: TListItem);
    procedure FillFieldsWithSelectedItem(var AFields: TDelphiAIDevDBRegistersFields);
  public
    property MadeChanges: Boolean read FMadeChanges;
  end;

implementation

uses
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA,
  DelphiAIDev.Types;

{$R *.dfm}

const
  C_INDEX_SUBITEM_DriverId = 0;
  C_INDEX_SUBITEM_Host = 1;
  C_INDEX_SUBITEM_User = 2;
  C_INDEX_SUBITEM_Port = 3;
  C_INDEX_SUBITEM_DatabaseName = 4;
  C_INDEX_SUBITEM_Visible = 5;
  C_INDEX_SUBITEM_LastReferences = 6;
  C_INDEX_SUBITEM_Password = 7;
  C_INDEX_SUBITEM_VendorLib = 8;
  C_INDEX_SUBITEM_Guid = 9;

procedure TDelphiAIDevDBRegistersView.FormCreate(Sender: TObject);
begin
  TUtilsOTA.IDEThemingAll(TDelphiAIDevDBRegistersView, Self);
  FUtilsListView := TDelphiAIDevUtilsListView.New(ListView);
end;

procedure TDelphiAIDevDBRegistersView.FormShow(Sender: TObject);
begin
  Self.ReloadData;

  if ListView.Items.Count > 0 then
    ListView.Items.Item[0].Selected := True;
  FMadeChanges := False;
  edtSearch.SetFocus;

  FUtilsListView
    .InvertOrder(True)
    .SortStyle(TDelphiAIDevUtilsListViewSortStyle.AlphaNum)
    .ColumnIndex(C_INDEX_SUBITEM_DatabaseName + 1)
    .CustomSort;
end;

procedure TDelphiAIDevDBRegistersView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F4:
      if ssAlt in Shift then
        Key := 0;
    VK_ESCAPE:
      if Shift = [] then
        btnClose.Click;
    VK_DOWN, VK_UP:
    begin
      if ListView <> ActiveControl then
      begin
        case Key of
          VK_DOWN:
            if ListView.ItemIndex < Pred(ListView.Items.Count) then
              ListView.ItemIndex := ListView.ItemIndex + 1;
          VK_UP:
            if ListView.ItemIndex > 0 then
              ListView.ItemIndex := ListView.ItemIndex - 1;
        end;
        Key := 0;
      end;
    end;
  end;
end;

procedure TDelphiAIDevDBRegistersView.btnCloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TDelphiAIDevDBRegistersView.edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    Self.ReloadData;
end;

procedure TDelphiAIDevDBRegistersView.btnSearchClick(Sender: TObject);
begin
  Self.ReloadData;
end;

procedure TDelphiAIDevDBRegistersView.ReloadData;
begin
  Screen.Cursor := crHourGlass;
  try
    Self.ReloadDataInternal;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TDelphiAIDevDBRegistersView.ReloadDataInternal;
var
  LStrSearch: string;
  LListItem: TListItem;
  LGuid: string;
begin
  LStrSearch := LowerCase(edtSearch.Text);

  if ListView.Selected <> nil then
    LGuid := ListView.Items[ListView.Selected.Index].SubItems[C_INDEX_SUBITEM_Guid];

  ListView.Clear;

  TDelphiAIDevDBRegistersModel.New.ReadData(
    procedure(AFields: TDelphiAIDevDBRegistersFields)
    begin
      if AFields.Description.Trim.IsEmpty then
        Exit;

      //if (AFields.Kind = TC4DQuestionKind.ItemMenuNormal) and (AFields.Question.Trim.IsEmpty) then
      //  Exit;

      if (LStrSearch.Trim.IsEmpty)
        or(AFields.Description.ToLower.Contains(LStrSearch))
        or(AFields.Host.ToLower.Contains(LStrSearch))
        or(AFields.DatabaseName.ToLower.Contains(LStrSearch))
      then
      begin
        LListItem := ListView.Items.Add;
        LListItem.Caption := AFields.Description;
        LListItem.ImageIndex := -1;
        LListItem.SubItems.Add(AFields.DriverID.ToString);
        LListItem.SubItems.Add(AFields.Host);
        LListItem.SubItems.Add(AFields.User);
        LListItem.SubItems.Add(AFields.Port.ToString);
        LListItem.SubItems.Add(AFields.DatabaseName);
        LListItem.SubItems.Add(TUtils.BoolToStrC4D(AFields.Visible));
        LListItem.SubItems.Add(TUtils.DateTimeToStrEmpty(AFields.LastReferences));
        LListItem.SubItems.Add(AFields.Password);
        LListItem.SubItems.Add(AFields.VendorLib);
        LListItem.SubItems.Add(AFields.Guid);
      end;
    end
  );

  FUtilsListView
    .InvertOrder(False)
    .CustomSort;

  if not LGuid.Trim.IsEmpty then
    TUtils.FindListVewItem(ListView, C_INDEX_SUBITEM_Guid, LGuid);

  Self.FillStatusBar(ListView.Selected);
end;

procedure TDelphiAIDevDBRegistersView.ListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  Self.FillStatusBar(Item);
end;

procedure TDelphiAIDevDBRegistersView.FillFieldsWithSelectedItem(var AFields: TDelphiAIDevDBRegistersFields);
var
  LListItem: TListItem;
begin
  AFields.Clear;
  if ListView.Selected = nil then
    Exit;

  LListItem := ListView.Items[ListView.Selected.Index];
  AFields.Description := LListItem.Caption;
  AFields.DriverID := TUtils.StrToDriverID(LListItem.SubItems[C_INDEX_SUBITEM_DriverId]);
  AFields.Host := LListItem.SubItems[C_INDEX_SUBITEM_Host];
  AFields.User := LListItem.SubItems[C_INDEX_SUBITEM_User];
  AFields.Port := StrToIntDef(LListItem.SubItems[C_INDEX_SUBITEM_Port], 0);
  AFields.DatabaseName := LListItem.SubItems[C_INDEX_SUBITEM_DatabaseName];
  AFields.Visible := TUtils.StrToBoolC4D(LListItem.SubItems[C_INDEX_SUBITEM_Visible]);
  AFields.LastReferences := StrToDateTimeDef(LListItem.SubItems[C_INDEX_SUBITEM_LastReferences], 0);
  AFields.Password := LListItem.SubItems[C_INDEX_SUBITEM_Password];
  AFields.VendorLib := LListItem.SubItems[C_INDEX_SUBITEM_VendorLib];
  AFields.Guid := LListItem.SubItems[C_INDEX_SUBITEM_Guid];
end;

procedure TDelphiAIDevDBRegistersView.FillStatusBar(AItem: TListItem);
var
  LIndex: Integer;
  LDatabaseName: string;
begin
  LIndex := -1;
  LDatabaseName := '';
  if AItem <> nil then
  begin
    LIndex := AItem.Index;
    LDatabaseName := ListView.Items[LIndex].SubItems[C_INDEX_SUBITEM_DatabaseName];
  end;

  StatusBar1.Panels[0].Text := Format('%d of %d', [LIndex + 1, ListView.Items.Count]);
  StatusBar1.Panels[1].Text := LDatabaseName;
end;

procedure TDelphiAIDevDBRegistersView.ListViewColumnClick(Sender: TObject; Column: TListColumn);
var
  LSortStyle: TDelphiAIDevUtilsListViewSortStyle;
begin
  LSortStyle := TDelphiAIDevUtilsListViewSortStyle.AlphaNum;
  case Column.Index of
    C_INDEX_SUBITEM_Port + 1:
      LSortStyle := TDelphiAIDevUtilsListViewSortStyle.Numeric;
  end;

  FUtilsListView
    .InvertOrder(True)
    .SortStyle(LSortStyle)
    .ColumnIndex(Column.Index)
    .CustomSort;
end;

procedure TDelphiAIDevDBRegistersView.ListViewDblClick(Sender: TObject);
begin
  btnEdit.Click
end;

procedure TDelphiAIDevDBRegistersView.ListViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnEdit.Click
end;

procedure TDelphiAIDevDBRegistersView.btnAddClick(Sender: TObject);
var
  LFields: TDelphiAIDevDBRegistersFields;
  LView: TDelphiAIDevDBRegistersAddEditView;
begin
  LFields := TDelphiAIDevDBRegistersFields.Create;
  try
    LView := TDelphiAIDevDBRegistersAddEditView.Create(nil);
    try
      LView.Caption := string(LView.Caption).Replace('[action]', 'Adding', [rfReplaceAll, rfIgnoreCase]);
      LView.Fields := LFields;

      if LView.ShowModal <> mrOk then
        Exit;

      FMadeChanges := True;
    finally
      LView.Free;
    end;
    Self.ReloadData;
  finally
    LFields.Free;
  end;
end;

procedure TDelphiAIDevDBRegistersView.btnEditClick(Sender: TObject);
var
  LFields: TDelphiAIDevDBRegistersFields;
  LView: TDelphiAIDevDBRegistersAddEditView;
begin
  if ListView.Selected = nil then
    Exit;

  LFields := TDelphiAIDevDBRegistersFields.Create;
  try
    Self.FillFieldsWithSelectedItem(LFields);

    if LFields.Description.Trim.IsEmpty then
      TUtils.ShowMsgErrorAndAbort('Description not found');

    LView := TDelphiAIDevDBRegistersAddEditView.Create(nil);
    try
      LView.Caption := string(LView.Caption).Replace('[action]', 'Editing', [rfReplaceAll, rfIgnoreCase]);
      LView.Fields := LFields;
      if LView.ShowModal <> mrOk then
        Exit;

      FMadeChanges := True;
    finally
      LView.Free;
    end;
    Self.ReloadData;
  finally
    LFields.Free;
  end;
end;

procedure TDelphiAIDevDBRegistersView.btnRemoveClick(Sender: TObject);
var
  LGuid: string;
begin
  if ListView.Selected = nil then
    Exit;

  LGuid := ListView.Items[ListView.Selected.Index].SubItems[C_INDEX_SUBITEM_Guid];
  if LGuid.Trim.IsEmpty then
    TUtils.ShowMsgErrorAndAbort('Guid not found');

//  if TC4DWizardOpenExternalModel.New.ExistGuidInIniFile(LId) then
//    TUtils.ShowMsgAndAbort('This registration cannot be deleted, as it is linked to other registration(s)');

  if not TUtils.ShowQuestion2('Confirm remove?') then
    Exit;

  Screen.Cursor := crHourGlass;
  try
    TDelphiAIDevDBRegistersModel.New.RemoveData(LGuid);
    Self.ReloadData;
  finally
    FMadeChanges := True;
    Screen.Cursor := crDefault;
  end;
end;

procedure TDelphiAIDevDBRegistersView.btnGenerateDatabaseReferenceClick(Sender: TObject);
var
  LView: TDelphiAIDevDBReferencesView;
  LFields: TDelphiAIDevDBRegistersFields;
begin
  if ListView.Selected = nil then
    Exit;

  LFields := TDelphiAIDevDBRegistersFields.Create;
  try
    Self.FillFieldsWithSelectedItem(LFields);

    if LFields.Description.Trim.IsEmpty then
      TUtils.ShowMsgErrorAndAbort('Description not found');

    LView := TDelphiAIDevDBReferencesView.Create(nil);
    try
      LView.Fields := LFields;
      if LView.ShowModal = mrOk then
        Self.ReloadData;
    finally
      LView.Free;
    end;
  finally
    LFields.Free;
  end;
end;

end.
