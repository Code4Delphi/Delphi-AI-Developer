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
  DelphiAIDev.DefaultsQuestions.Model;

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
    FModel: TDelphiAIDevDefaultsQuestionsModel;
    procedure MenuMasterLoad;
    procedure MenuMasterClear;
  public
    property Model: TDelphiAIDevDefaultsQuestionsModel read FModel write FModel;
  end;

implementation

uses
  DelphiAIDev.Consts,
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA,
  DelphiAIDev.DefaultsQuestions.Dao;

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
  mmQuestion.Lines.Text := FModel.Question;
  edtOrder.Text := FModel.Order.Tostring;
  ckVisible.Checked := FModel.Visible;
  ckCodeOnly.Checked := FModel.CodeOnly;

  Self.MenuMasterLoad;
  mmQuestion.SetFocus;
end;

procedure TDelphiAIDevDefaultsQuestionsAddEditView.MenuMasterClear;
var
  I: Integer;
  LModel: TDelphiAIDevDefaultsQuestionsModel;
begin
  for I := Pred(cBoxMenuMaster.Items.Count) downto 0 do
  begin
    LModel := TDelphiAIDevDefaultsQuestionsModel(cBoxMenuMaster.Items.Objects[I]);
    LModel.Free;
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
  TDelphiAIDevDefaultsQuestionsDao.New.ReadData(
    procedure(AModel: TDelphiAIDevDefaultsQuestionsModel)
    var
      LModel: TDelphiAIDevDefaultsQuestionsModel;
      LItemIndex: Integer;
    begin
      //if(AModel.Kind <> TC4DWizardOpenExternalKind.MenuMasterOnly)then
      //  Exit;

      LModel := TDelphiAIDevDefaultsQuestionsModel.Create;
      LModel.Guid := AModel.Guid;
      LModel.Question := AModel.Question;
      LItemIndex := cBoxMenuMaster.Items.AddObject(LModel.Question, LModel);

      //if (FModel.IdParent > 0)and(FModel.IdParent = LModel.IdParent) then
      //  LItemIndexDefault := LItemIndex;

      if(FModel.GuidMenuMaster = LModel.Guid)then
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

  FModel.Question := mmQuestion.Lines.Text;
  FModel.Order := StrToIntDef(edtOrder.Text, 0);
  FModel.Visible := ckVisible.Checked;
  FModel.CodeOnly := ckCodeOnly.Checked;

  FModel.GuidMenuMaster := '';
  if(cBoxMenuMaster.ItemIndex >= 0)then
    if(TDelphiAIDevDefaultsQuestionsModel(cBoxMenuMaster.Items.Objects[cBoxMenuMaster.ItemIndex]) <> nil)then
      FModel.GuidMenuMaster := TDelphiAIDevDefaultsQuestionsModel(cBoxMenuMaster.Items.Objects[cBoxMenuMaster.ItemIndex]).Guid;

  TDelphiAIDevDefaultsQuestionsDao.New.SaveOrEditData(FModel);

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
