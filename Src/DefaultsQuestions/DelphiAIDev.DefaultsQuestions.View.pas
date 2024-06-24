unit DelphiAIDev.DefaultsQuestions.View;

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
  DelphiAIDev.Utils.ListView;

type
  TDelphiAIDevDefaultsQuestionsView = class(TForm)
    Panel1: TPanel;
    btnEdit: TButton;
    btnClose: TButton;
    ListViewHistory: TListView;
    pnTop: TPanel;
    btnSearch: TButton;
    edtSearch: TEdit;
    StatusBar1: TStatusBar;
    btnAdd: TButton;
    btnRemove: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure ListViewHistorySelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure ListViewHistoryDblClick(Sender: TObject);
    procedure ListViewHistoryKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnEditClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListViewHistoryColumnClick(Sender: TObject; Column: TListColumn);
  private
    FUtilsListView: IDelphiAIDevUtilsListView;
    FReloadPopupMenuChat: Boolean;
    procedure ReloadData;
    procedure FillStatusBar(AItem: TListItem);
    //procedure FillOpenExternalSelectedItem(var AC4DWizardOpenExternal: TC4DWizardOpenExternal);
  public

  end;

var
  DelphiAIDevDefaultsQuestionsView: TDelphiAIDevDefaultsQuestionsView;

procedure DelphiAIDevDefaultsQuestionsViewShow;

implementation

uses
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA,
  DelphiAIDev.Types;

{$R *.dfm}

const
  C_INDEX_SUBITEM_Order = 0;
  C_INDEX_SUBITEM_Visible = 1;
  C_INDEX_SUBITEM_CodeOnly = 2;
  C_INDEX_SUBITEM_Id = 3;
  C_INDEX_SUBITEM_IdParent = 4;

procedure DelphiAIDevDefaultsQuestionsViewShow;
begin
  DelphiAIDevDefaultsQuestionsView := TDelphiAIDevDefaultsQuestionsView.Create(nil);
  try
    DelphiAIDevDefaultsQuestionsView.ShowModal;
  finally
    FreeAndNil(DelphiAIDevDefaultsQuestionsView);
  end;
end;

procedure TDelphiAIDevDefaultsQuestionsView.FormCreate(Sender: TObject);
begin
  TUtilsOTA.IDEThemingAll(TDelphiAIDevDefaultsQuestionsView, Self);
  FUtilsListView := TDelphiAIDevUtilsListView.New(ListViewHistory);
end;

procedure TDelphiAIDevDefaultsQuestionsView.FormShow(Sender: TObject);
begin
  Self.ReloadData;

  if(ListViewHistory.Items.Count > 0)then
    ListViewHistory.Items.Item[0].Selected := True;
  FReloadPopupMenuChat := False;
  edtSearch.SetFocus;

  FUtilsListView
    .InvertOrder(False)
    .SortStyle(TDelphiAIDevUtilsListViewSortStyle.Numeric)
    .ColumnIndex(C_INDEX_SUBITEM_Order + 1)
    .CustomSort;
end;

procedure TDelphiAIDevDefaultsQuestionsView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if(FReloadPopupMenuChat)then
  begin
    //
  end;
end;

procedure TDelphiAIDevDefaultsQuestionsView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case(Key)of
    VK_F4:
    if(ssAlt in Shift)then
      Key := 0;
    VK_ESCAPE:
    if(Shift = [])then
      btnClose.Click;
    VK_DOWN, VK_UP:
    begin
      if(ListViewHistory <> ActiveControl)then
      begin
        case(Key)of
          VK_DOWN:
          if(ListViewHistory.ItemIndex < Pred(ListViewHistory.Items.Count))then
            ListViewHistory.ItemIndex := ListViewHistory.ItemIndex + 1;
          VK_UP:
          if(ListViewHistory.ItemIndex > 0)then
            ListViewHistory.ItemIndex := ListViewHistory.ItemIndex - 1;
        end;
        Key := 0;
      end;
    end;
  end;
end;

procedure TDelphiAIDevDefaultsQuestionsView.btnCloseClick(Sender: TObject);
begin
  Self.Close;
  Self.ModalResult := mrCancel;
end;

procedure TDelphiAIDevDefaultsQuestionsView.btnSearchClick(Sender: TObject);
begin
  Self.ReloadData;
end;

procedure TDelphiAIDevDefaultsQuestionsView.edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if(Key = VK_RETURN)then
    Self.ReloadData;
end;

procedure TDelphiAIDevDefaultsQuestionsView.ReloadData;
var
  LStrSearch: string;
  LListItem: TListItem;
  LId: string;
begin
  LStrSearch := LowerCase(edtSearch.Text);

  if(ListViewHistory.Selected <> nil)then
    LId := ListViewHistory.Items[ListViewHistory.Selected.Index].SubItems[C_INDEX_SUBITEM_Id];

  ListViewHistory.Clear;
  {TC4DWizardOpenExternalModel.New.ReadIniFile(
    procedure(AC4DWizardOpenExternal: TC4DWizardOpenExternal)
    begin
      if(LStrSearch.Trim.IsEmpty)
        or(AC4DWizardOpenExternal.Description.ToLower.Contains(LStrSearch))
        or(AC4DWizardOpenExternal.Path.ToLower.Contains(LStrSearch))
      then
      begin
        LListItem := ListViewHistory.Items.Add;
        LListItem.Caption := AC4DWizardOpenExternal.Description;
        LListItem.ImageIndex := -1;
        LListItem.SubItems.Add(AC4DWizardOpenExternal.Order.Tostring);
        LListItem.SubItems.Add(AC4DWizardOpenExternal.Shortcut);
        LListItem.SubItems.Add(AC4DWizardOpenExternal.Kind.Tostring);
        LListItem.SubItems.Add(TC4DWizardUtils.BoolToStrC4D(AC4DWizardOpenExternal.Visible));
        LListItem.SubItems.Add(TC4DWizardUtils.BoolToStrC4D(AC4DWizardOpenExternal.VisibleInToolBarUtilities));
        LListItem.SubItems.Add(AC4DWizardOpenExternal.Path);
        LListItem.SubItems.Add(AC4DWizardOpenExternal.Parameters);
        LListItem.SubItems.Add(TC4DWizardUtils.BoolToStrC4D(AC4DWizardOpenExternal.IconHas));
        LListItem.SubItems.Add(AC4DWizardOpenExternal.Guid);
        LListItem.SubItems.Add(AC4DWizardOpenExternal.GuidMenuMaster);
      end;
    end
    ); }

  FUtilsListView
    .InvertOrder(False)
    .CustomSort;

  if(not LId.Trim.IsEmpty)then
    TUtils.FindListVewItem(ListViewHistory, C_INDEX_SUBITEM_Id, LId);

  Self.FillStatusBar(ListViewHistory.Selected);
end;

procedure TDelphiAIDevDefaultsQuestionsView.ListViewHistorySelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  Self.FillStatusBar(Item);
end;

procedure TDelphiAIDevDefaultsQuestionsView.FillStatusBar(AItem: TListItem);
var
  LIndex: Integer;
  LQuestion: string;
begin
  LIndex := -1;
  LQuestion := '';
  if(AItem <> nil)then
  begin
    LIndex := AItem.Index;
    LQuestion := ListViewHistory.Items[LIndex].ToString //.SubItems[C_INDEX_SUBITEM_Question];
  end;

  StatusBar1.Panels[0].Text := Format('%d of %d', [LIndex + 1, ListViewHistory.Items.Count]);
  StatusBar1.Panels[1].Text := LQuestion;
end;

procedure TDelphiAIDevDefaultsQuestionsView.ListViewHistoryColumnClick(Sender: TObject; Column: TListColumn);
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

procedure TDelphiAIDevDefaultsQuestionsView.ListViewHistoryDblClick(Sender: TObject);
begin
  btnEdit.Click
end;

procedure TDelphiAIDevDefaultsQuestionsView.ListViewHistoryKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if(Key = VK_RETURN)then
    btnEdit.Click
end;

procedure TDelphiAIDevDefaultsQuestionsView.btnAddClick(Sender: TObject);
//var
//  LC4DWizardOpenExternal: TC4DWizardOpenExternal;
begin
//  LC4DWizardOpenExternal := TC4DWizardOpenExternal.Create;
//  try
//    LC4DWizardOpenExternal.Guid := TC4DWizardUtils.GetGuidStr;
//    LC4DWizardOpenExternal.Visible := True;
//    LC4DWizardOpenExternal.VisibleInToolBarUtilities := False;
//    C4DWizardOpenExternalAddEditView := TC4DWizardOpenExternalAddEditView.Create(nil);
//    try
//      C4DWizardOpenExternalAddEditView.Caption := 'Code4D Open External - Adding';
//      C4DWizardOpenExternalAddEditView.C4DWizardOpenExternal := LC4DWizardOpenExternal;
//      if(C4DWizardOpenExternalAddEditView.ShowModal <> mrOk)then
//        Exit;
//      FReloadPopupMenuChat := True;
//    finally
//      FreeAndNil(C4DWizardOpenExternalAddEditView);
//    end;
//    Self.ReloadData;
//  finally
//    LC4DWizardOpenExternal.Free;
//  end;
end;

procedure TDelphiAIDevDefaultsQuestionsView.btnEditClick(Sender: TObject);
//var
//  LC4DWizardOpenExternal: TC4DWizardOpenExternal;
begin
//  if(ListViewHistory.Selected = nil)then
//    Exit;
//
//  LC4DWizardOpenExternal := TC4DWizardOpenExternal.Create;
//  try
//    Self.FillOpenExternalSelectedItem(LC4DWizardOpenExternal);
//    if(LC4DWizardOpenExternal.Description.Trim.IsEmpty)then
//      TC4DWizardUtils.ShowMsgErrorAndAbort('Name group not found');
//
//    C4DWizardOpenExternalAddEditView := TC4DWizardOpenExternalAddEditView.Create(nil);
//    try
//      C4DWizardOpenExternalAddEditView.Caption := 'Code4D Open External - Editing';
//      C4DWizardOpenExternalAddEditView.C4DWizardOpenExternal := LC4DWizardOpenExternal;
//      if(C4DWizardOpenExternalAddEditView.ShowModal <> mrOk)then
//        Exit;
//      FReloadPopupMenuChat := True;
//    finally
//      FreeAndNil(C4DWizardOpenExternalAddEditView);
//    end;
//    Self.ReloadData;
//  finally
//    LC4DWizardOpenExternal.Free;
//  end;
end;

{procedure TDelphiAIDevDefaultsQuestionsView.FillSelectedItem(var AC4DWizardOpenExternal: TC4DWizardOpenExternal);
var
  LListItem: TListItem;
begin
  AC4DWizardOpenExternal.Clear;
  if(ListViewHistory.Selected = nil)then
    Exit;

  LListItem := ListViewHistory.Items[ListViewHistory.Selected.Index];
  AC4DWizardOpenExternal.Description := LListItem.Caption;
  AC4DWizardOpenExternal.Order := StrToIntDef(LListItem.SubItems[C_INDEX_SUBITEM_Order], 0);
  AC4DWizardOpenExternal.Shortcut := LListItem.SubItems[C_INDEX_SUBITEM_Shortcut];
  AC4DWizardOpenExternal.Kind := TC4DWizardUtils.StrToOpenExternalKind(LListItem.SubItems[C_INDEX_SUBITEM_Kind]);
  AC4DWizardOpenExternal.Visible := TC4DWizardUtils.StrToBoolC4D(LListItem.SubItems[C_INDEX_SUBITEM_Visible]);
  AC4DWizardOpenExternal.VisibleInToolBarUtilities := TC4DWizardUtils.StrToBoolC4D(LListItem.SubItems[C_INDEX_SUBITEM_VisibleToolBarUtilities]);

  AC4DWizardOpenExternal.Path := LListItem.SubItems[C_INDEX_SUBITEM_Path];
  AC4DWizardOpenExternal.Parameters := LListItem.SubItems[C_INDEX_SUBITEM_Parameters];
  AC4DWizardOpenExternal.IconHas := TC4DWizardUtils.StrToBoolC4D(LListItem.SubItems[C_INDEX_SUBITEM_IconHas]);
  AC4DWizardOpenExternal.Guid := LListItem.SubItems[C_INDEX_SUBITEM_Guid];
  AC4DWizardOpenExternal.GuidMenuMaster := LListItem.SubItems[C_INDEX_SUBITEM_GuidMenuMaster];
end;}

procedure TDelphiAIDevDefaultsQuestionsView.btnRemoveClick(Sender: TObject);
var
  LId: string;
begin
  if(ListViewHistory.Selected = nil)then
    Exit;

  LId := ListViewHistory.Items[ListViewHistory.Selected.Index].SubItems[C_INDEX_SUBITEM_Id];
  if(LId.Trim.IsEmpty)then
    TUtils.ShowMsgErrorAndAbort('Guid not found');

//  if(TC4DWizardOpenExternalModel.New.ExistGuidInIniFile(LId))then
//    TUtils.ShowMsgAndAbort('This registration cannot be deleted, as it is linked to other registration(s)');

  if(not TUtils.ShowQuestion2('Confirm remove?'))then
    Exit;

  Screen.Cursor := crHourGlass;
  try
    //TC4DWizardOpenExternalModel.New.RemoveGuidInIniFile(LId);
    Self.ReloadData;
  finally
    FReloadPopupMenuChat := True;
    Screen.Cursor := crDefault;
  end;
end;

end.
