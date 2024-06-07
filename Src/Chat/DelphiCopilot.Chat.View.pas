unit DelphiCopilot.Chat.View;

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
  DockForm,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Menus,
  System.ImageList,
  Vcl.ImgList;

type
  TDelphiCopilotChatView = class(TDockableForm)
    ImageList1: TImageList;
    ColorDialog1: TColorDialog;
    FontDialog1: TFontDialog;
    PopupMenu1: TPopupMenu;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    SelectAll1: TMenuItem;
    N2: TMenuItem;
    BackgroundColor1: TMenuItem;
    BackgroundSelectColor1: TMenuItem;
    BackgroundeDefaultColor1: TMenuItem;
    pnBack: TPanel;
    RichEdit: TRichEdit;
    pnTop: TPanel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    btnColor: TButton;
    cBoxSizeFont: TComboBox;
    btnAlignmentLeft: TButton;
    btnAlignmentCenter: TButton;
    btnAlignmentRight: TButton;
    btnUnderline: TButton;
    btnItalic: TButton;
    btnBold: TButton;
    btnFont: TButton;
    btnOpen: TButton;
    btnSaveAs: TButton;
    btnSave: TButton;
    btnStrikethrough: TButton;
    Bevel1: TBevel;
    btnFontSizeDecrease: TButton;
    btnFontSizeIncrease: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveAsClick(Sender: TObject);
    procedure btnColorClick(Sender: TObject);
    procedure cBoxSizeFontClick(Sender: TObject);
    procedure cBoxSizeFontKeyPress(Sender: TObject; var Key: Char);
    procedure BackgroundSelectColor1Click(Sender: TObject);
    procedure BackgroundeDefaultColor1Click(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure btnAlignmentLeftClick(Sender: TObject);
    procedure btnAlignmentCenterClick(Sender: TObject);
    procedure btnAlignmentRightClick(Sender: TObject);
    procedure btnBoldClick(Sender: TObject);
    procedure btnItalicClick(Sender: TObject);
    procedure btnUnderlineClick(Sender: TObject);
    procedure btnStrikethroughClick(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFontSizeDecreaseClick(Sender: TObject);
    procedure btnFontSizeIncreaseClick(Sender: TObject);
  private
    procedure ReadFromFile;
    procedure WriteToFile;
    procedure ChangeAlignment(const AAlignment: TAlignment);
    procedure ChangeStyle(const AStyle: TFontStyle);
    procedure ChangeFontSize(const AValue: Integer);
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  DelphiCopilotChatView: TDelphiCopilotChatView;

procedure RegisterSelf;
procedure Unregister;
procedure DelphiCopilotChatViewShowDockableForm;

implementation

uses
  DeskUtil,
  DelphiCopilot.Utils,
  DelphiCopilot.Utils.OTA;


{$R *.dfm}

procedure RegisterSelf;
begin
  if(not Assigned(DelphiCopilotChatView))then
    DelphiCopilotChatView := TDelphiCopilotChatView.Create(nil);

  if(@RegisterFieldAddress <> nil)then
    RegisterFieldAddress(DelphiCopilotChatView.Name, @DelphiCopilotChatView);

  RegisterDesktopFormClass(TDelphiCopilotChatView, DelphiCopilotChatView.Name, DelphiCopilotChatView.Name);
end;

procedure Unregister;
begin
  if(@UnRegisterFieldAddress <> nil)then
    UnRegisterFieldAddress(@DelphiCopilotChatView);
  FreeAndNil(DelphiCopilotChatView);
end;

procedure DelphiCopilotChatViewShowDockableForm;
begin
  ShowDockableForm(DelphiCopilotChatView);
  FocusWindow(DelphiCopilotChatView);
end;

constructor TDelphiCopilotChatView.Create(AOwner: TComponent);
begin
  inherited;
  DeskSection := Self.Name;
  AutoSave := True;
  SaveStateNecessary := True;

  TDelphiCopilotUtilsOTA.IDEThemingAll(TDelphiCopilotChatView, Self);
end;

procedure TDelphiCopilotChatView.FormShow(Sender: TObject);
begin
  Self.Constraints.MinWidth := 100;
  Self.Constraints.MinHeight := 100;

  RichEdit.Font.Color := TDelphiCopilotUtilsOTA.ActiveThemeColorDefaul;
  Self.ReadFromFile;
end;

procedure TDelphiCopilotChatView.FormActivate(Sender: TObject);
begin
  //RichEdit.Font.Color := TDelphiCopilotUtilsOTA.ActiveThemeColorDefaul;
  //Self.ReadFromFile;
end;

procedure TDelphiCopilotChatView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.WriteToFile;
end;

procedure TDelphiCopilotChatView.ReadFromFile;
begin
  if(FileExists(TDelphiCopilotUtils.GetPathFileNotes))then
    RichEdit.Lines.LoadFromFile(TDelphiCopilotUtils.GetPathFileNotes)
end;

procedure TDelphiCopilotChatView.WriteToFile;
begin
  RichEdit.Lines.SaveToFile(TDelphiCopilotUtils.GetPathFileNotes);
end;

procedure TDelphiCopilotChatView.btnOpenClick(Sender: TObject);
var
  LOpenDialog: TOpenDialog;
begin
  LOpenDialog := TOpenDialog.Create(nil);
  try
    LOpenDialog.DefaultExt := 'rtf';
    LOpenDialog.Filter := 'File RTF|*.rtf';
    LOpenDialog.InitialDir := '';
    LOpenDialog.FileName := '';
    if(not LOpenDialog.Execute)then
      Exit;

    RichEdit.Lines.LoadFromFile(LOpenDialog.FileName);
  finally
    LOpenDialog.Free;
  end;
end;

procedure TDelphiCopilotChatView.btnSaveClick(Sender: TObject);
begin
  Self.WriteToFile;
end;

procedure TDelphiCopilotChatView.btnSaveAsClick(Sender: TObject);
var
 LSaveDialog: TSaveDialog;
begin
  LSaveDialog := TSaveDialog.Create(nil);
  try
    LSaveDialog.Title := 'Code4D-Wizard - Save File As';
    LSaveDialog.DefaulText := '*.rtf';
    LSaveDialog.Filter := 'Arquivos RTF (*.rtf)|*.rtf|Arquivos TXT (*.txt)|*.txt|Todos os Arquivos (*.*)|*.*';
    LSaveDialog.FileName := 'Code4D-Wizard-Notes-' + FormatDateTime('yyyyMMdd-hhnnss', now) + '.rtf';
    LSaveDialog.InitialDir := '';

    if(not LSaveDialog.Execute)then
      Exit;

    if(FileExists(LSaveDialog.FileName))then
      if(not TDelphiCopilotUtils.ShowQuestion2('There is already a file with the same name in this location. Want to replace it?'))then
        Exit;

    RichEdit.Lines.SaveToFile(LSaveDialog.FileName);
    TDelphiCopilotUtils.ShowV('Successful saving file');
  finally
    LSaveDialog.Free;
  end;
end;

procedure TDelphiCopilotChatView.btnColorClick(Sender: TObject);
begin
  if(ColorDialog1.Execute)then
    RichEdit.SelAttributes.Color := ColorDialog1.Color;
  RichEdit.SetFocus;
end;

procedure TDelphiCopilotChatView.cBoxSizeFontClick(Sender: TObject);
var
  LSize: Integer;
begin
  LSize := StrToIntDef(cBoxSizeFont.Text, 0);
  if(LSize > 7)then
    RichEdit.SelAttributes.Size := LSize;
end;

procedure TDelphiCopilotChatView.cBoxSizeFontKeyPress(Sender: TObject; var Key: Char);
begin
  if not(CharInSet(Key, ['0'..'9', #8]))then
    key := #0;
end;

procedure TDelphiCopilotChatView.BackgroundSelectColor1Click(Sender: TObject);
begin
  if(ColorDialog1.Execute)then
    RichEdit.Color := ColorDialog1.Color;
  RichEdit.SetFocus;
end;

procedure TDelphiCopilotChatView.BackgroundeDefaultColor1Click(Sender: TObject);
begin
  RichEdit.ParentColor := True;
  RichEdit.SetFocus;
end;

procedure TDelphiCopilotChatView.btnFontClick(Sender: TObject);
begin
  FontDialog1.Font.Color := RichEdit.SelAttributes.Color;
  FontDialog1.Font.Name := RichEdit.SelAttributes.Name;
  FontDialog1.Font.Size := RichEdit.SelAttributes.Size;
  FontDialog1.Font.Style := RichEdit.SelAttributes.Style;

  if(FontDialog1.Execute)then
  begin
    RichEdit.SelAttributes.Color := FontDialog1.Font.Color;
    RichEdit.SelAttributes.Name := FontDialog1.Font.Name;
    RichEdit.SelAttributes.Size := FontDialog1.Font.Size;
    cBoxSizeFont.Text := IntToStr(FontDialog1.Font.size);
    RichEdit.SelAttributes.Style := FontDialog1.Font.Style;
  end;
  RichEdit.SetFocus;
end;

procedure TDelphiCopilotChatView.btnBoldClick(Sender: TObject);
begin
  Self.ChangeStyle(fsBold);
end;

procedure TDelphiCopilotChatView.btnFontSizeDecreaseClick(Sender: TObject);
begin
  Self.ChangeFontSize(-1);
end;

procedure TDelphiCopilotChatView.btnFontSizeIncreaseClick(Sender: TObject);
begin
  Self.ChangeFontSize(+1);
end;

procedure TDelphiCopilotChatView.ChangeFontSize(const AValue: Integer);
begin
  try
    if(RichEdit.SelAttributes.Size <= 7)then
      Exit;

    RichEdit.SelAttributes.Size := RichEdit.SelAttributes.Size + AValue;
    cBoxSizeFont.Text := IntToStr(RichEdit.SelAttributes.Size);
  finally
    RichEdit.SetFocus;
  end;
end;

procedure TDelphiCopilotChatView.btnItalicClick(Sender: TObject);
begin
  Self.ChangeStyle(fsItalic);
end;

procedure TDelphiCopilotChatView.btnUnderlineClick(Sender: TObject);
begin
  Self.ChangeStyle(fsUnderline);
end;

procedure TDelphiCopilotChatView.btnStrikethroughClick(Sender: TObject);
begin
  Self.ChangeStyle(fsStrikeOut);
end;

procedure TDelphiCopilotChatView.ChangeStyle(const AStyle: TFontStyle);
begin
  if(AStyle in RichEdit.SelAttributes.Style)then
    RichEdit.SelAttributes.Style := RichEdit.SelAttributes.Style - [AStyle]
  else
    RichEdit.SelAttributes.Style := RichEdit.SelAttributes.Style + [AStyle];
  RichEdit.SetFocus;
end;

procedure TDelphiCopilotChatView.btnAlignmentLeftClick(Sender: TObject);
begin
  Self.ChangeAlignment(taLeftJustify);
end;

procedure TDelphiCopilotChatView.btnAlignmentCenterClick(Sender: TObject);
begin
  Self.ChangeAlignment(taCenter);
end;

procedure TDelphiCopilotChatView.btnAlignmentRightClick(Sender: TObject);
begin
  Self.ChangeAlignment(taRightJustify);
end;

procedure TDelphiCopilotChatView.ChangeAlignment(const AAlignment: TAlignment);
begin
  RichEdit.Paragraph.Alignment := AAlignment;
  RichEdit.SetFocus;
end;

procedure TDelphiCopilotChatView.Cut1Click(Sender: TObject);
begin
  RichEdit.CutToClipboard;
end;

procedure TDelphiCopilotChatView.Copy1Click(Sender: TObject);
begin
  RichEdit.CopyToClipboard;
end;

procedure TDelphiCopilotChatView.Paste1Click(Sender: TObject);
begin
  RichEdit.PasteFromClipboard;
end;

procedure TDelphiCopilotChatView.SelectAll1Click(Sender: TObject);
begin
  RichEdit.SelectAll;
end;

initialization

finalization
  Unregister;

end.
