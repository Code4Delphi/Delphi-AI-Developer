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
  DelphiAIDev.DefaultsQuestions.Model,
  DelphiAIDev.DefaultsQuestions.Fields,
  DelphiAIDev.DefaultsQuestions.AddEdit.View;

type
  TDelphiAIDevDefaultsQuestionsView = class(TForm)
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
    FReloadPopupMenuChat: Boolean;
    procedure ReloadData;
    procedure ReloadDataInternal;
    procedure FillStatusBar(AItem: TListItem);
    procedure FillFieldsWithSelectedItem(var AFields: TDelphiAIDevDefaultsQuestionsFields);
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
  C_INDEX_SUBITEM_Kind = 0;
  C_INDEX_SUBITEM_Order = 1;
  C_INDEX_SUBITEM_Visible = 2;
  C_INDEX_SUBITEM_CodeOnly = 3;
  C_INDEX_SUBITEM_Guid = 4;
  C_INDEX_SUBITEM_GuidMenuMaster = 5;
  C_INDEX_SUBITEM_Question = 6;

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
  FUtilsListView := TDelphiAIDevUtilsListView.New(ListView);
end;

procedure TDelphiAIDevDefaultsQuestionsView.FormShow(Sender: TObject);
begin
  Self.ReloadData;

  if(ListView.Items.Count > 0)then
    ListView.Items.Item[0].Selected := True;
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
      if(ListView <> ActiveControl)then
      begin
        case(Key)of
          VK_DOWN:
          if(ListView.ItemIndex < Pred(ListView.Items.Count))then
            ListView.ItemIndex := ListView.ItemIndex + 1;
          VK_UP:
          if(ListView.ItemIndex > 0)then
            ListView.ItemIndex := ListView.ItemIndex - 1;
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

procedure TDelphiAIDevDefaultsQuestionsView.edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if(Key = VK_RETURN)then
    Self.ReloadData;
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

  if(ListView.Selected <> nil)then
    LGuid := ListView.Items[ListView.Selected.Index].SubItems[C_INDEX_SUBITEM_Guid];

  ListView.Clear;

  TDelphiAIDevDefaultsQuestionsModel.New.ReadData(
    procedure(AFields: TDelphiAIDevDefaultsQuestionsFields)
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

procedure TDelphiAIDevDefaultsQuestionsView.ListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  Self.FillStatusBar(Item);
end;

procedure TDelphiAIDevDefaultsQuestionsView.FillFieldsWithSelectedItem(var AFields: TDelphiAIDevDefaultsQuestionsFields);
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
  AFields.Kind := TUtils.StrToDefaultsQuestionsKind(LListItem.SubItems[C_INDEX_SUBITEM_Kind]);
  AFields.Order := StrToIntDef(LListItem.SubItems[C_INDEX_SUBITEM_Order], 0);
  AFields.Visible := TUtils.StrToBoolC4D(LListItem.SubItems[C_INDEX_SUBITEM_Visible]);
  AFields.CodeOnly := TUtils.StrToBoolC4D(LListItem.SubItems[C_INDEX_SUBITEM_CodeOnly]);
  AFields.Question := LListItem.SubItems[C_INDEX_SUBITEM_Question];
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
    LQuestion := ListView.Items[LIndex].SubItems[C_INDEX_SUBITEM_Question];
  end;

  StatusBar1.Panels[0].Text := Format('%d of %d', [LIndex + 1, ListView.Items.Count]);
  StatusBar1.Panels[1].Text := LQuestion;
end;

procedure TDelphiAIDevDefaultsQuestionsView.ListViewColumnClick(Sender: TObject; Column: TListColumn);
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

procedure TDelphiAIDevDefaultsQuestionsView.ListViewDblClick(Sender: TObject);
begin
  btnEdit.Click
end;

procedure TDelphiAIDevDefaultsQuestionsView.ListViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if(Key = VK_RETURN)then
    btnEdit.Click
end;

procedure TDelphiAIDevDefaultsQuestionsView.btnAddClick(Sender: TObject);
var
  LFields: TDelphiAIDevDefaultsQuestionsFields;
  LView: TDelphiAIDevDefaultsQuestionsAddEditView;
begin
  LFields := TDelphiAIDevDefaultsQuestionsFields.Create;
  try
    //LFields.Guid := '';
    LView := TDelphiAIDevDefaultsQuestionsAddEditView.Create(nil);
    try
      LView.Caption := string(LView.Caption).Replace('[action]', 'Adding', [rfReplaceAll, rfIgnoreCase]);
      LView.Fields := LFields;

      if(LView.ShowModal <> mrOk)then
        Exit;

      FReloadPopupMenuChat := True;
    finally
      LView.Free;
    end;
    Self.ReloadData;
  finally
    LFields.Free;
  end;
end;

procedure TDelphiAIDevDefaultsQuestionsView.btnEditClick(Sender: TObject);
var
  LFields: TDelphiAIDevDefaultsQuestionsFields;
  LView: TDelphiAIDevDefaultsQuestionsAddEditView;
begin
  if(ListView.Selected = nil)then
    Exit;

  LFields := TDelphiAIDevDefaultsQuestionsFields.Create;
  try
    Self.FillFieldsWithSelectedItem(LFields);

    if(LFields.Caption.Trim.IsEmpty)then
      TUtils.ShowMsgErrorAndAbort('Caption not found');

    LView := TDelphiAIDevDefaultsQuestionsAddEditView.Create(nil);
    try
      LView.Caption := string(LView.Caption).Replace('[action]', 'Editing', [rfReplaceAll, rfIgnoreCase]);
      LView.Fields := LFields;
      if(LView.ShowModal <> mrOk)then
        Exit;

      FReloadPopupMenuChat := True;
    finally
      LView.Free;
    end;
    Self.ReloadData;
  finally
    LFields.Free;
  end;
end;

procedure TDelphiAIDevDefaultsQuestionsView.btnRemoveClick(Sender: TObject);
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
    TDelphiAIDevDefaultsQuestionsModel.New.RemoveData(LGuid);
    Self.ReloadData;
  finally
    FReloadPopupMenuChat := True;
    Screen.Cursor := crDefault;
  end;
end;

end.
