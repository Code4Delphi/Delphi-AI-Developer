unit DelphiCopilot.Chat.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.JSON,
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
  Vcl.ImgList,
  Vcl.Buttons,
  Clipbrd,
  RESTRequest4D,
  fs_synmemo,
  ToolsAPI;

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
    pnBack: TPanel;
    Panel3: TPanel;
    Panel1: TPanel;
    btnSend: TButton;
    mmQuestion: TMemo;
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
    btnFontSizeDecrease: TButton;
    btnFontSizeIncrease: TButton;
    mmReturn: TfsSyntaxMemo;
    Panel9: TPanel;
    btnCopy: TSpeedButton;
    btnInsertAtCursor: TSpeedButton;
    btnMoreActions: TSpeedButton;
    Panel2: TPanel;
    Shape1: TShape;
    SpeedButton1: TSpeedButton;
    Shape3: TShape;
    N1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveAsClick(Sender: TObject);
    procedure cBoxSizeFontKeyPress(Sender: TObject; var Key: Char);
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
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFontSizeDecreaseClick(Sender: TObject);
    procedure btnFontSizeIncreaseClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure mmQuestionKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCopyClick(Sender: TObject);
    procedure btnInsertAtCursorClick(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
  private
    procedure ReadFromFile;
    procedure WriteToFile;
    procedure ChangeAlignment(const AAlignment: TAlignment);
    procedure ChangeStyle(const AStyle: TFontStyle);
    procedure ChangeFontSize(const AValue: Integer);
    function ConfReturn(const AValue: string): string;
    procedure ConfmmReturn;
    procedure ProcessSend;
    procedure ProcessBlockSelected;
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

  //mmReturn.Font.Color := TDelphiCopilotUtilsOTA.ActiveThemeColorDefaul;
  Self.ConfmmReturn;
  Self.ReadFromFile;
end;

procedure TDelphiCopilotChatView.ConfmmReturn;
begin
  //mmReturn.Font.Color := TDelphiCopilotUtilsOTA.ActiveThemeColorDefaul;

  //Exit;
  if TDelphiCopilotUtilsOTA.ActiveThemeIsDark then
  begin
    mmReturn.Color := $004A4136; //COR EDIDOR
    mmReturn.CommentAttr.Color := $0084E7BC; //COMENTARIOS
    mmReturn.KeywordAttr.Color := $00BCE0FF; //PALAVRAS CHAVES
    mmReturn.StringAttr.Color := $00E0713C; //TEXTOS ENTRE ASPAS
    mmReturn.TextAttr.Color := clWhite; //DEMAIS TEXTOS

    mmReturn.BlockColor := $00FFAA7F; //CODE SELECIONADO
    mmReturn.BlockFontColor := clWindowText; //CODE SELECIONADO
  end;

  //COR EDIDOR$004A4136;
  //COMETARIO: $0084E7BC
  //AZUL TEXTO: CLARO: $00FFAA7F  ESCURO: $00E0713C
  //KeyWord palavras chaves: $00BCE0FF
  //CODE SELECIONADO: clHighlight DO DELPHI: $00FFAA7F
end;

procedure TDelphiCopilotChatView.mmQuestionKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift)and(Key = VK_RETURN) then
  begin
    btnSend.Click;
    Key := 0;
  end;
end;

procedure TDelphiCopilotChatView.FormActivate(Sender: TObject);
begin
  //mmReturn.Font.Color := TDelphiCopilotUtilsOTA.ActiveThemeColorDefaul;
  //Self.ReadFromFile;
end;

procedure TDelphiCopilotChatView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.WriteToFile;
end;

procedure TDelphiCopilotChatView.ReadFromFile;
begin
  if(FileExists(TDelphiCopilotUtils.GetPathFileNotes))then
    mmReturn.Lines.LoadFromFile(TDelphiCopilotUtils.GetPathFileNotes)
end;

procedure TDelphiCopilotChatView.SelectAll1Click(Sender: TObject);
begin
  mmReturn.SelText
end;

procedure TDelphiCopilotChatView.WriteToFile;
begin
  mmReturn.Lines.SaveToFile(TDelphiCopilotUtils.GetPathFileNotes);
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

    mmReturn.Lines.LoadFromFile(LOpenDialog.FileName);
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
    LSaveDialog.Title := 'Copilot - Save File As';
    LSaveDialog.DefaulText := '*.rtf';
    LSaveDialog.Filter := 'Arquivos RTF (*.rtf)|*.rtf|Arquivos TXT (*.txt)|*.txt|Todos os Arquivos (*.*)|*.*';
    LSaveDialog.FileName := 'Copilot-Notes-' + FormatDateTime('yyyyMMdd-hhnnss', now) + '.rtf';
    LSaveDialog.InitialDir := '';

    if(not LSaveDialog.Execute)then
      Exit;

    if(FileExists(LSaveDialog.FileName))then
      if(not TDelphiCopilotUtils.ShowQuestion2('There is already a file with the same name in this location. Want to replace it?'))then
        Exit;

    mmReturn.Lines.SaveToFile(LSaveDialog.FileName);
    TDelphiCopilotUtils.ShowV('Successful saving file');
  finally
    LSaveDialog.Free;
  end;
end;

procedure TDelphiCopilotChatView.cBoxSizeFontKeyPress(Sender: TObject; var Key: Char);
begin
  if not(CharInSet(Key, ['0'..'9', #8]))then
    key := #0;
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

end;

procedure TDelphiCopilotChatView.Cut1Click(Sender: TObject);
begin
  mmReturn.CutToClipboard;
end;

procedure TDelphiCopilotChatView.Copy1Click(Sender: TObject);
begin
  mmReturn.CopyToClipboard;
end;

procedure TDelphiCopilotChatView.Paste1Click(Sender: TObject);
begin
  mmReturn.PasteFromClipboard;
end;

function TDelphiCopilotChatView.ConfReturn(const AValue: string): string;
begin
  Result := AValue
    .Replace('```delphi', '', [rfReplaceAll, rfIgnoreCase])
    .Replace('```', '', [rfReplaceAll]);
end;

procedure TDelphiCopilotChatView.btnSendClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    Self.ProcessSend;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TDelphiCopilotChatView.ProcessSend;
const
  API_URL = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=%s';
  API_KEY = 'AIzaSyArzMx-zCQPdBt9FT7hkWThwPTw2Hco6tM';
  API_JSON_BODY_BASE = '{"contents": [{"parts": [ {"text": "%s"}]}]}';
var
  LResponse: IResponse;

  JsonValue: TJSONVALUE;
  JsonArray, PartsArray: TJsonArray;
  JsonObj, PartsObj: TJsonObject;
  JsonText: String;
  i, j: Integer;
begin
  mmReturn.Lines.Clear;
  LResponse := TRequest.New
    .BaseURL(Format(API_URL, [API_KEY]))
    .Accept('application/json')
    .AddBody(Format(API_JSON_BODY_BASE, [mmQuestion.Lines.Text]))
    .Post;

  if LResponse.StatusCode <> 200 then
  begin
    mmReturn.Lines.Add('Question cannot be answered');
    mmReturn.Lines.Add('Return: ' + LResponse.Content);
    Exit;
  end;

  JsonValue := TJsonObject.ParseJSONValue(LResponse.Content);
  if JsonValue is TJsonObject then
  begin
    JsonArray := (JsonValue as TJsonObject).GetValue<TJsonArray>('candidates');
    for i := 0 to JsonArray.Count - 1 do
    begin
      JsonObj := JsonArray.Items[i].GetValue<TJsonObject>('content');
      PartsArray := JsonObj.GetValue<TJsonArray>('parts');
      for j := 0 to PartsArray.Count - 1 do
      begin
        PartsObj := PartsArray.Items[j] as TJsonObject;
        JsonText := PartsObj.GetValue<string>('text');
        mmReturn.Lines.Text := Self.ConfReturn(JsonText);
      end;
    end;
  end;
end;

procedure TDelphiCopilotChatView.btnCopyClick(Sender: TObject);
begin
  Clipboard.AsText := mmReturn.SelText;
end;

procedure TDelphiCopilotChatView.btnInsertAtCursorClick(Sender: TObject);
var
  LIOTAEditorServices: IOTAEditorServices;
  LIOTAEditView: IOTAEditView;
  LStartRow: Integer;
  LIOTAEditBlock: IOTAEditBlock;
  LText: string;
begin
  LIOTAEditorServices := TDelphiCopilotUtilsOTA.GetIOTAEditorServices;
  LIOTAEditView := LIOTAEditorServices.TopView;
  if(LIOTAEditView = nil)then
    TDelphiCopilotUtils.ShowMsgAndAbort('No projects or files selected');

  LIOTAEditBlock := LIOTAEditView.Block;
  if not Assigned(LIOTAEditBlock) then
    Exit;

  LText := LIOTAEditBlock.Text;
  if not LText.Trim.IsEmpty then
  begin
    LStartRow := LIOTAEditBlock.StartingRow;
    LIOTAEditBlock.Delete;
    LIOTAEditView.Position.Move(LStartRow, 1);
  end;

  TDelphiCopilotUtilsOTA.InsertBlockTextIntoEditor(mmReturn.SelText);
end;

procedure TDelphiCopilotChatView.ProcessBlockSelected;
var
  LIOTAEditorServices: IOTAEditorServices;
  LIOTAEditView: IOTAEditView;
  LStartRow: Integer;
  LIOTAEditBlock: IOTAEditBlock;
  LText: string;
begin
  LIOTAEditorServices := TDelphiCopilotUtilsOTA.GetIOTAEditorServices;
  LIOTAEditView := LIOTAEditorServices.TopView;
  if(LIOTAEditView = nil)then
    TDelphiCopilotUtils.ShowMsgAndAbort('No projects or files selected');

//  LIOTAEditBlock := LIOTAEditView.Block;
//  if not Assigned(LIOTAEditBlock) then
//    Exit;

//  LText := LIOTAEditBlock.Text;
//  if(LText.Trim.IsEmpty)then
//    TDelphiCopilotUtils.ShowMsgAndAbort('Not text selected');

//  Self.Process;
//  LStartRow := LIOTAEditBlock.StartingRow;
//  LIOTAEditBlock.Delete;
//  LIOTAEditView.Position.Move(LStartRow, 1);
  TDelphiCopilotUtilsOTA.InsertBlockTextIntoEditor('AQUI');
end;

initialization

finalization
  Unregister;

end.
