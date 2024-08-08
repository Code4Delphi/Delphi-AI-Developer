unit DelphiAIDev.Databases.View;

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
  DelphiAIDev.Utils.ListView,
  DelphiAIDev.Databases.Model,
  DelphiAIDev.Databases.Fields;
  //DelphiAIDev.Databases.AddEdit.View;

type
  TDelphiAIDevDatabasesView = class(TForm)
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
  private
    FUtilsListView: IDelphiAIDevUtilsListView;
    FMadeChanges: Boolean;
    procedure ReloadData;
    procedure ReloadDataInternal;
    procedure FillStatusBar(AItem: TListItem);
    procedure FillFieldsWithSelectedItem(var AFields: TDelphiAIDevDatabasesFields);
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
  C_INDEX_SUBITEM_Password = 5;
  C_INDEX_SUBITEM_Guid = 6;

procedure TDelphiAIDevDatabasesView.FormCreate(Sender: TObject);
begin
  TUtilsOTA.IDEThemingAll(TDelphiAIDevDatabasesView, Self);
  FUtilsListView := TDelphiAIDevUtilsListView.New(ListView);
end;

procedure TDelphiAIDevDatabasesView.FormShow(Sender: TObject);
begin
  Self.ReloadData;

  if ListView.Items.Count > 0 then
    ListView.Items.Item[0].Selected := True;
  FMadeChanges := False;
  edtSearch.SetFocus;

  FUtilsListView
    .InvertOrder(False)
    .SortStyle(TDelphiAIDevUtilsListViewSortStyle.Numeric)
    .ColumnIndex(C_INDEX_SUBITEM_DatabaseName + 1)
    .CustomSort;
end;

procedure TDelphiAIDevDatabasesView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TDelphiAIDevDatabasesView.btnCloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TDelphiAIDevDatabasesView.edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    Self.ReloadData;
end;

procedure TDelphiAIDevDatabasesView.btnSearchClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    Self.ReloadData;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TDelphiAIDevDatabasesView.ReloadData;
begin
  Screen.Cursor := crHourGlass;
  try
    Self.ReloadDataInternal;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TDelphiAIDevDatabasesView.ReloadDataInternal;
var
  LStrSearch: string;
  LListItem: TListItem;
  LGuid: string;
begin
  LStrSearch := LowerCase(edtSearch.Text);

  if ListView.Selected <> nil then
    LGuid := ListView.Items[ListView.Selected.Index].SubItems[C_INDEX_SUBITEM_Guid];

  ListView.Clear;

  TDelphiAIDevDatabasesModel.New.ReadData(
    procedure(AFields: TDelphiAIDevDatabasesFields)
    begin
      if AFields.Caption.Trim.IsEmpty then
        Exit;

      if (AFields.Kind = TC4DQuestionKind.ItemMenuNormal) and (AFields.Question.Trim.IsEmpty) then
        Exit;

      if(LStrSearch.Trim.IsEmpty)
        or(AFields.Caption.ToLower.Contains(LStrSearch))
        or(AFields.Question.ToLower.Contains(LStrSearch))
      then
      begin
        LListItem := ListView.Items.Add;
        LListItem.Caption := AFields.Caption;
        LListItem.ImageIndex := -1;
        LListItem.SubItems.Add(AFields.Kind.Tostring);
        LListItem.SubItems.Add(AFields.Order.Tostring);
        LListItem.SubItems.Add(TUtils.BoolToStrC4D(AFields.Visible));
        LListItem.SubItems.Add(TUtils.BoolToStrC4D(AFields.CodeOnly));
        LListItem.SubItems.Add(AFields.Guid);
        LListItem.SubItems.Add(AFields.GuidMenuMaster);
        LListItem.SubItems.Add(AFields.Question);
      end;
    end
  );

  FUtilsListView
    .InvertOrder(False)
    .CustomSort;

  if(not LGuid.Trim.IsEmpty)then
    TUtils.FindListVewItem(ListView, C_INDEX_SUBITEM_Guid, LGuid);

  Self.FillStatusBar(ListView.Selected);
end;

procedure TDelphiAIDevDatabasesView.ListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  Self.FillStatusBar(Item);
end;

procedure TDelphiAIDevDatabasesView.FillFieldsWithSelectedItem(var AFields: TDelphiAIDevDatabasesFields);
var
  LListItem: TListItem;
begin
  AFields.Clear;
  if(ListView.Selected = nil)then
    Exit;

  LListItem := ListView.Items[ListView.Selected.Index];
  AFields.Guid := LListItem.SubItems[C_INDEX_SUBITEM_Guid];
  AFields.GuidMenuMaster := LListItem.SubItems[C_INDEX_SUBITEM_GuidMenuMaster];
  AFields.Caption := LListItem.Caption;
  AFields.Kind := TUtils.StrToDatabasesKind(LListItem.SubItems[C_INDEX_SUBITEM_Kind]);
  AFields.Order := StrToIntDef(LListItem.SubItems[C_INDEX_SUBITEM_Order], 0);
  AFields.Visible := TUtils.StrToBoolC4D(LListItem.SubItems[C_INDEX_SUBITEM_Visible]);
  AFields.CodeOnly := TUtils.StrToBoolC4D(LListItem.SubItems[C_INDEX_SUBITEM_CodeOnly]);
  AFields.Question := LListItem.SubItems[C_INDEX_SUBITEM_Question];
end;

procedure TDelphiAIDevDatabasesView.FillStatusBar(AItem: TListItem);
var
  LIndex: Integer;
  LQuestion: string;
begin
  LIndex := -1;
  LQuestion := '';
  if(AItem <> nil)then
  begin
    LIndex := AItem.Index;
    LQuestion := ListView.Items[LIndex].SubItems[C_INDEX_SUBITEM_Question];
  end;

  StatusBar1.Panels[0].Text := Format('%d of %d', [LIndex + 1, ListView.Items.Count]);
  StatusBar1.Panels[1].Text := LQuestion;
end;

procedure TDelphiAIDevDatabasesView.ListViewColumnClick(Sender: TObject; Column: TListColumn);
var
  LSortStyle: TDelphiAIDevUtilsListViewSortStyle;
begin
  LSortStyle := TDelphiAIDevUtilsListViewSortStyle.AlphaNum;
  case(Column.Index)of
    C_INDEX_SUBITEM_Order + 1:
    LSortStyle := TDelphiAIDevUtilsListViewSortStyle.Numeric;
  end;

  FUtilsListView
    .InvertOrder(True)
    .SortStyle(LSortStyle)
    .ColumnIndex(Column.Index)
    .CustomSort;
end;

procedure TDelphiAIDevDatabasesView.ListViewDblClick(Sender: TObject);
begin
  btnEdit.Click
end;

procedure TDelphiAIDevDatabasesView.ListViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnEdit.Click
end;

procedure TDelphiAIDevDatabasesView.btnAddClick(Sender: TObject);
var
  LFields: TDelphiAIDevDatabasesFields;
  LView: TDelphiAIDevDatabasesAddEditView;
begin
  LFields := TDelphiAIDevDatabasesFields.Create;
  try
    //LFields.Guid := '';
    LView := TDelphiAIDevDatabasesAddEditView.Create(nil);
    try
      LView.Caption := string(LView.Caption).Replace('[action]', 'Adding', [rfReplaceAll, rfIgnoreCase]);
      LView.Fields := LFields;

      if(LView.ShowModal <> mrOk)then
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

procedure TDelphiAIDevDatabasesView.btnEditClick(Sender: TObject);
var
  LFields: TDelphiAIDevDatabasesFields;
  LView: TDelphiAIDevDatabasesAddEditView;
begin
  if(ListView.Selected = nil)then
    Exit;

  LFields := TDelphiAIDevDatabasesFields.Create;
  try
    Self.FillFieldsWithSelectedItem(LFields);

    if(LFields.Caption.Trim.IsEmpty)then
      TUtils.ShowMsgErrorAndAbort('Caption not found');

    LView := TDelphiAIDevDatabasesAddEditView.Create(nil);
    try
      LView.Caption := string(LView.Caption).Replace('[action]', 'Editing', [rfReplaceAll, rfIgnoreCase]);
      LView.Fields := LFields;
      if(LView.ShowModal <> mrOk)then
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

procedure TDelphiAIDevDatabasesView.btnRemoveClick(Sender: TObject);
var
  LGuid: string;
begin
  if(ListView.Selected = nil)then
    Exit;

  LGuid := ListView.Items[ListView.Selected.Index].SubItems[C_INDEX_SUBITEM_Guid];
  if(LGuid.Trim.IsEmpty)then
    TUtils.ShowMsgErrorAndAbort('Guid not found');

//  if(TC4DWizardOpenExternalModel.New.ExistGuidInIniFile(LId))then
//    TUtils.ShowMsgAndAbort('This registration cannot be deleted, as it is linked to other registration(s)');

  if(not TUtils.ShowQuestion2('Confirm remove?'))then
    Exit;

  Screen.Cursor := crHourGlass;
  try
    TDelphiAIDevDatabasesModel.New.RemoveData(LGuid);
    Self.ReloadData;
  finally
    FMadeChanges := True;
    Screen.Cursor := crDefault;
  end;
end;

end.
