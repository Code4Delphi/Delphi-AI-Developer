unit DelphiAIDev.DefaultsQuestions.AddEdit.View;

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
  DelphiAIDev.DefaultsQuestions.Fields;

type
  TDelphiAIDevDefaultsQuestionsAddEditView = class(TForm)
    Panel1: TPanel;
    btnConfirm: TButton;
    btnClose: TButton;
    Panel9: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    edtOrder: TEdit;
    UpDown1: TUpDown;
    ckVisible: TCheckBox;
    Bevel2: TBevel;
    ckCodeOnly: TCheckBox;
    Label9: TLabel;
    cBoxMenuMaster: TComboBox;
    mmQuestion: TMemo;
    Label2: TLabel;
    cBoxKind: TComboBox;
    Label3: TLabel;
    edtCaption: TEdit;
    procedure btnCloseClick(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cBoxKindChange(Sender: TObject);
  private
    FFields: TDelphiAIDevDefaultsQuestionsFields;
    FLastCaption: string;
    FLastQuestion: string;
    FLastItemIndexMenuMaster: Integer;
    procedure FillcBoxKind;
    procedure MenuMasterLoad;
    procedure MenuMasterClear;
    procedure ConfFieldsKind;
  public
    property Fields: TDelphiAIDevDefaultsQuestionsFields read FFields write FFields;
  end;

implementation

uses
  DelphiAIDev.Consts,
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA,
  DelphiAIDev.DefaultsQuestions.Model;

{$R *.dfm}

procedure TDelphiAIDevDefaultsQuestionsAddEditView.FillcBoxKind;
begin
  cBoxKind.Items.Clear;
  TUtils.DefaultsQuestionsKindFillItemsTStrings(cBoxKind.Items);
end;

procedure TDelphiAIDevDefaultsQuestionsAddEditView.FormCreate(Sender: TObject);
begin
  Self.ModalResult := mrCancel;

  TUtilsOTA.IDEThemingAll(TDelphiAIDevDefaultsQuestionsAddEditView, Self);

  FLastCaption := '';
  FLastQuestion := '';
  FLastItemIndexMenuMaster := 0;
  Self.FillcBoxKind;
end;

procedure TDelphiAIDevDefaultsQuestionsAddEditView.FormDestroy(Sender: TObject);
begin
  Self.MenuMasterClear;
end;

procedure TDelphiAIDevDefaultsQuestionsAddEditView.FormShow(Sender: TObject);
begin
  cBoxKind.ItemIndex := cBoxKind.Items.IndexOf(FFields.Kind.ToString);
  edtCaption.Text := FFields.Caption;
  mmQuestion.Lines.Text := FFields.Question;
  edtOrder.Text := FFields.Order.Tostring;
  ckVisible.Checked := FFields.Visible;
  ckCodeOnly.Checked := FFields.CodeOnly;

  Self.ConfFieldsKind;
  Self.MenuMasterLoad;
  if edtCaption.CanFocus then
    edtCaption.SetFocus
  else if cBoxKind.CanFocus then
    cBoxKind.SetFocus;
end;

procedure TDelphiAIDevDefaultsQuestionsAddEditView.MenuMasterClear;
var
  I: Integer;
  LFields: TDelphiAIDevDefaultsQuestionsFields;
begin
  for I := Pred(cBoxMenuMaster.Items.Count) downto 0 do
  begin
    LFields := TDelphiAIDevDefaultsQuestionsFields(cBoxMenuMaster.Items.Objects[I]);
    LFields.Free;
  end;
  cBoxMenuMaster.Items.Clear;
end;

procedure TDelphiAIDevDefaultsQuestionsAddEditView.MenuMasterLoad;
var
  LItemIndexDefault: Integer;
begin
  Self.MenuMasterClear;

  cBoxMenuMaster.Items.AddObject('None', nil);

  LItemIndexDefault := 0;
  TDelphiAIDevDefaultsQuestionsModel.New.ReadData(
    procedure(AFields: TDelphiAIDevDefaultsQuestionsFields)
    var
      LFields: TDelphiAIDevDefaultsQuestionsFields;
      LItemIndex: Integer;
    begin
      if(AFields.Kind <> TC4DQuestionKind.MenuMasterOnly)then
        Exit;

      LFields := TDelphiAIDevDefaultsQuestionsFields.Create;
      LFields.Guid := AFields.Guid;
      LFields.Caption := AFields.Caption;
      LItemIndex := cBoxMenuMaster.Items.AddObject(LFields.Caption, LFields);

      //if (FFields.IdParent > 0)and(FFields.IdParent = LFields.IdParent) then
      //  LItemIndexDefault := LItemIndex;

      if(FFields.GuidMenuMaster = LFields.Guid)then
        LItemIndexDefault := LItemIndex;
    end
    );

  cBoxMenuMaster.ItemIndex := LItemIndexDefault;
end;

procedure TDelphiAIDevDefaultsQuestionsAddEditView.btnCloseClick(Sender: TObject);
begin
  Self.Close;
  Self.ModalResult := mrCancel;
end;

procedure TDelphiAIDevDefaultsQuestionsAddEditView.btnConfirmClick(Sender: TObject);
begin
  if(cBoxKind.ItemIndex <= 0)then
    TUtils.ShowMsgAndAbort('No informed Kind', cBoxKind);

  if Trim(edtCaption.Text).IsEmpty then
    TUtils.ShowMsgAndAbort('No informed Caption', edtCaption);

  if (mmQuestion.Enabled) and (Trim(mmQuestion.Lines.Text).IsEmpty )then
    TUtils.ShowMsgAndAbort('No informed Question', mmQuestion);

  FFields.Kind := TUtils.StrToDefaultsQuestionsKind(cBoxKind.Text);
  FFields.Caption := edtCaption.Text;
  FFields.Question := mmQuestion.Lines.Text;
  FFields.Order := StrToIntDef(edtOrder.Text, 0);
  FFields.Visible := ckVisible.Checked;
  FFields.CodeOnly := ckCodeOnly.Checked;

  FFields.GuidMenuMaster := '';
  if(cBoxMenuMaster.ItemIndex >= 0)then
    if(TDelphiAIDevDefaultsQuestionsFields(cBoxMenuMaster.Items.Objects[cBoxMenuMaster.ItemIndex]) <> nil)then
      FFields.GuidMenuMaster := TDelphiAIDevDefaultsQuestionsFields(cBoxMenuMaster.Items.Objects[cBoxMenuMaster.ItemIndex]).Guid;

  TDelphiAIDevDefaultsQuestionsModel.New.SaveOrEditData(FFields);

  Self.Close;
  Self.ModalResult := mrOK;
end;

procedure TDelphiAIDevDefaultsQuestionsAddEditView.cBoxKindChange(Sender: TObject);
begin
  Self.ConfFieldsKind;
end;

procedure TDelphiAIDevDefaultsQuestionsAddEditView.ConfFieldsKind;
begin
  edtCaption.Enabled := True;
  mmQuestion.Enabled := True;
  cBoxMenuMaster.Enabled := True;

  if(cBoxKind.Text = TC4DQuestionKind.Separators.ToString)then
  begin
    FLastCaption := edtCaption.Text;
    edtCaption.Text := '-';
    edtCaption.Enabled := False;

    FLastQuestion := mmQuestion.Lines.Text;
    mmQuestion.Lines.Clear;
    mmQuestion.Enabled := False;
  end
  else if(cBoxKind.Text = TC4DQuestionKind.MenuMasterOnly.ToString)then
  begin
    if(edtCaption.Text = '-')and(not FLastCaption.Trim.IsEmpty)then
      edtCaption.Text := FLastCaption;

    FLastQuestion := mmQuestion.Lines.Text;
    mmQuestion.Lines.Clear;
    mmQuestion.Enabled := False;

    //FLastItemIndexMenuMaster := cBoxMenuMaster.ItemIndex;
    //cBoxMenuMaster.ItemIndex := 0;
    //cBoxMenuMaster.Enabled := False;
  end
  else
  begin
    if(edtCaption.Text = '-')and(not FLastCaption.Trim.IsEmpty)then
      edtCaption.Text := FLastCaption;

    if(mmQuestion.Text = '')and(not FLastQuestion.Trim.IsEmpty)then
      mmQuestion.Text := FLastQuestion;
  end;

  if(cBoxKind.Text <> TC4DQuestionKind.MenuMasterOnly.ToString)then
  begin
    if(cBoxMenuMaster.ItemIndex <= 0)then
      cBoxMenuMaster.ItemIndex := FLastItemIndexMenuMaster;
  end;
end;

procedure TDelphiAIDevDefaultsQuestionsAddEditView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

end.
