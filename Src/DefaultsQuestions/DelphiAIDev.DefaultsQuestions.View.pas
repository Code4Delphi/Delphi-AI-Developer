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
  DelphiAIDev.Utils.ListView,
  DelphiAIDev.DefaultsQuestions.Dao,
  DelphiAIDev.DefaultsQuestions.Model,
  DelphiAIDev.DefaultsQuestions.AddEdit.View;

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
    procedure ReloadDataInternal;
    procedure FillStatusBar(AItem: TListItem);
    procedure FillModelWithSelectedItem(var AModel: TDelphiAIDevDefaultsQuestionsModel);
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
  C_INDEX_SUBITEM_Guid = 3;
  C_INDEX_SUBITEM_GuidMenuMaster = 4;

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
  Screen.Cursor := crHourGlass;
  try
    Self.ReloadData;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TDelphiAIDevDefaultsQuestionsView.edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if(Key = VK_RETURN)then
    Self.ReloadData;
end;

procedure TDelphiAIDevDefaultsQuestionsView.ReloadData;
begin
  Screen.Cursor := crHourGlass;
  try
    Self.ReloadDataInternal;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TDelphiAIDevDefaultsQuestionsView.ReloadDataInternal;
var
  LStrSearch: string;
  LListItem: TListItem;
  LGuid: string;
begin
  LStrSearch := LowerCase(edtSearch.Text);

  if(ListViewHistory.Selected <> nil)then
    LGuid := ListViewHistory.Items[ListViewHistory.Selected.Index].SubItems[C_INDEX_SUBITEM_Guid];

  ListViewHistory.Clear;

  TDelphiAIDevDefaultsQuestionsDao.New.ReadData(
    procedure(AModel: TDelphiAIDevDefaultsQuestionsModel)
    begin
      if AModel.Question.Trim.IsEmpty then
        Exit;

      if(LStrSearch.Trim.IsEmpty)
        or(AModel.Question.ToLower.Contains(LStrSearch))
      then
      begin
        LListItem := ListViewHistory.Items.Add;
        LListItem.Caption := AModel.Question;
        LListItem.ImageIndex := -1;
        LListItem.SubItems.Add(AModel.Order.Tostring);
        LListItem.SubItems.Add(TUtils.BoolToStrC4D(AModel.Visible));
        LListItem.SubItems.Add(TUtils.BoolToStrC4D(AModel.CodeOnly));
        LListItem.SubItems.Add(AModel.Guid);
        LListItem.SubItems.Add(AModel.GuidMenuMaster);
      end;
    end
  );

  FUtilsListView
    .InvertOrder(False)
    .CustomSort;

  if(not LGuid.Trim.IsEmpty)then
    TUtils.FindListVewItem(ListViewHistory, C_INDEX_SUBITEM_Guid, LGuid);

  Self.FillStatusBar(ListViewHistory.Selected);
end;

procedure TDelphiAIDevDefaultsQuestionsView.ListViewHistorySelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  Self.FillStatusBar(Item);
end;

procedure TDelphiAIDevDefaultsQuestionsView.FillModelWithSelectedItem(var AModel: TDelphiAIDevDefaultsQuestionsModel);
var
  LListItem: TListItem;
begin
  AModel.Clear;
  if(ListViewHistory.Selected = nil)then
    Exit;

  LListItem := ListViewHistory.Items[ListViewHistory.Selected.Index];
  AModel.Guid := LListItem.SubItems[C_INDEX_SUBITEM_Guid];
  AModel.GuidMenuMaster := LListItem.SubItems[C_INDEX_SUBITEM_GuidMenuMaster];
  AModel.Question := LListItem.Caption;
  AModel.Order := StrToIntDef(LListItem.SubItems[C_INDEX_SUBITEM_Order], 0);
  AModel.Visible := TUtils.StrToBoolC4D(LListItem.SubItems[C_INDEX_SUBITEM_Visible]);
  AModel.CodeOnly := TUtils.StrToBoolC4D(LListItem.SubItems[C_INDEX_SUBITEM_CodeOnly]);
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
    LQuestion := ListViewHistory.Items[LIndex].Caption //.SubItems[C_INDEX_SUBITEM_Question];
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
var
  LModel: TDelphiAIDevDefaultsQuestionsModel;
  LView: TDelphiAIDevDefaultsQuestionsAddEditView;
begin
  LModel := TDelphiAIDevDefaultsQuestionsModel.Create;
  try
    //LModel.Guid := '';
    LView := TDelphiAIDevDefaultsQuestionsAddEditView.Create(nil);
    try
      LView.Caption := string(LView.Caption).Replace('[action]', 'Adding', [rfReplaceAll, rfIgnoreCase]);
      LView.Model := LModel;

      if(LView.ShowModal <> mrOk)then
        Exit;

      FReloadPopupMenuChat := True;
    finally
      LView.Free;
    end;
    Self.ReloadData;
  finally
    LModel.Free;
  end;
end;

procedure TDelphiAIDevDefaultsQuestionsView.btnEditClick(Sender: TObject);
var
  LModel: TDelphiAIDevDefaultsQuestionsModel;
  LView: TDelphiAIDevDefaultsQuestionsAddEditView;
begin
  if(ListViewHistory.Selected = nil)then
    Exit;

  LModel := TDelphiAIDevDefaultsQuestionsModel.Create;
  try
    Self.FillModelWithSelectedItem(LModel);
    if(LModel.Question.Trim.IsEmpty)then
      TUtils.ShowMsgErrorAndAbort('Question not found');

    LView := TDelphiAIDevDefaultsQuestionsAddEditView.Create(nil);
    try
      LView.Caption := string(LView.Caption).Replace('[action]', 'Editing', [rfReplaceAll, rfIgnoreCase]);
      LView.Model := LModel;
      if(LView.ShowModal <> mrOk)then
        Exit;

      FReloadPopupMenuChat := True;
    finally
      LView.Free;
    end;
    Self.ReloadData;
  finally
    LModel.Free;
  end;
end;

procedure TDelphiAIDevDefaultsQuestionsView.btnRemoveClick(Sender: TObject);
var
  LGuid: string;
begin
  if(ListViewHistory.Selected = nil)then
    Exit;

  LGuid := ListViewHistory.Items[ListViewHistory.Selected.Index].SubItems[C_INDEX_SUBITEM_Guid];
  if(LGuid.Trim.IsEmpty)then
    TUtils.ShowMsgErrorAndAbort('Guid not found');

//  if(TC4DWizardOpenExternalModel.New.ExistGuidInIniFile(LId))then
//    TUtils.ShowMsgAndAbort('This registration cannot be deleted, as it is linked to other registration(s)');

  if(not TUtils.ShowQuestion2('Confirm remove?'))then
    Exit;

  Screen.Cursor := crHourGlass;
  try
    TDelphiAIDevDefaultsQuestionsDao.New.RemoveData(LGuid);
    Self.ReloadData;
  finally
    FReloadPopupMenuChat := True;
    Screen.Cursor := crDefault;
  end;
end;

end.
