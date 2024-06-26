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
    procedure btnCloseClick(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FFields: TDelphiAIDevDefaultsQuestionsFields;
    procedure MenuMasterLoad;
    procedure MenuMasterClear;
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

procedure TDelphiAIDevDefaultsQuestionsAddEditView.FormCreate(Sender: TObject);
begin
  Self.ModalResult := mrCancel;

  TUtilsOTA.IDEThemingAll(TDelphiAIDevDefaultsQuestionsAddEditView, Self);
end;

procedure TDelphiAIDevDefaultsQuestionsAddEditView.FormDestroy(Sender: TObject);
begin
  Self.MenuMasterClear;
end;

procedure TDelphiAIDevDefaultsQuestionsAddEditView.FormShow(Sender: TObject);
begin
  mmQuestion.Lines.Text := FFields.Question;
  edtOrder.Text := FFields.Order.Tostring;
  ckVisible.Checked := FFields.Visible;
  ckCodeOnly.Checked := FFields.CodeOnly;

  Self.MenuMasterLoad;
  mmQuestion.SetFocus;
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
      //if(AFields.Kind <> TC4DWizardOpenExternalKind.MenuMasterOnly)then
      //  Exit;

      LFields := TDelphiAIDevDefaultsQuestionsFields.Create;
      LFields.Guid := AFields.Guid;
      LFields.Question := AFields.Question;
      LItemIndex := cBoxMenuMaster.Items.AddObject(LFields.Question, LFields);

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
  if Trim(mmQuestion.Lines.Text).IsEmpty then
    TUtils.ShowMsgAndAbort('No informed Description', mmQuestion);

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
