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
  ToolsAPI;

type
  TDelphiCopilotChatView = class(TDockableForm)
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    SelectAll1: TMenuItem;
    pnBack: TPanel;
    pnBottom: TPanel;
    pnBackBtnSend: TPanel;
    btnSend: TButton;
    mmQuestion: TMemo;
    pnCommands: TPanel;
    btnCopy: TSpeedButton;
    btnInsertAtCursor: TSpeedButton;
    btnMoreActions: TSpeedButton;
    Shape3: TShape;
    N1: TMenuItem;
    mmReturn: TRichEdit;
    Splitter1: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure cBoxSizeFontKeyPress(Sender: TObject; var Key: Char);
    procedure Cut1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSendClick(Sender: TObject);
    procedure mmQuestionKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCopyClick(Sender: TObject);
    procedure btnInsertAtCursorClick(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
  private
    procedure ReadFromFile;
    procedure WriteToFile;
    procedure InitializeRichEditReturn;
    procedure ProcessSend;
    procedure InternalAdd(AString: string);
    procedure Last;
    function GetSelectedTextOrAll: string;
    procedure GetSelectedBlockForQuestion;
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

  Self.InitializeRichEditReturn;
  Self.ReadFromFile;
  Self.GetSelectedBlockForQuestion;

  mmQuestion.SelectAll;
  mmQuestion.SelStart := Length(mmQuestion.Text);
  mmQuestion.SetFocus;
end;

procedure TDelphiCopilotChatView.GetSelectedBlockForQuestion;
var
  LBlockTextSelect: string;
begin
  LBlockTextSelect := TDelphiCopilotUtilsOTA.GetBlockTextSelect;
  if not LBlockTextSelect.Trim.IsEmpty then
    mmQuestion.Text := LBlockTextSelect;
end;

procedure TDelphiCopilotChatView.InitializeRichEditReturn;
begin
  mmReturn.Lines.Clear;
  mmReturn.SelAttributes.Name := 'Courier New';
  mmReturn.SelAttributes.Size := 10;

  if TDelphiCopilotUtilsOTA.ActiveThemeIsDark then
  begin
    mmReturn.Color := $004A4136;
    mmReturn.SelAttributes.Color := clWhite;    
  end
  else
  begin
    mmReturn.Color := clWindow;
    mmReturn.SelAttributes.Color := clWindowText;
  end; 
end;

procedure TDelphiCopilotChatView.InternalAdd(AString: string);
begin  
  Self.Last;

  if TDelphiCopilotUtilsOTA.ActiveThemeIsDark then
    mmReturn.SelAttributes.Color := clWhite
  else
    mmReturn.SelAttributes.Color := clWindowText;
    
  mmReturn.SelAttributes.Style := [];
  
  mmReturn.Lines.Add(AString);
  Self.Last;   
end;

procedure TDelphiCopilotChatView.mmQuestionKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift)and(Key = VK_RETURN) then
  begin
    btnSend.Click;
    Key := 0;
  end
  else if (Key = Ord('A')) and (ssCtrl in Shift) then
  begin
    mmQuestion.SelectAll;
    Key := 0;
  end;
end;

procedure TDelphiCopilotChatView.FormActivate(Sender: TObject);
begin
  //mmReturn.Font.Color := TDelphiCopilotUtilsOTA.ActiveThemeColorDefault;
  //Self.ReadFromFile;
end;

procedure TDelphiCopilotChatView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.WriteToFile;
end;

procedure TDelphiCopilotChatView.ReadFromFile;
begin
  if(FileExists(TDelphiCopilotUtils.GetPathFileChat))then
    mmReturn.Lines.LoadFromFile(TDelphiCopilotUtils.GetPathFileChat)
end;

procedure TDelphiCopilotChatView.SelectAll1Click(Sender: TObject);
begin
  mmReturn.SelectAll;
end;

procedure TDelphiCopilotChatView.WriteToFile;
begin
  mmReturn.Lines.SaveToFile(TDelphiCopilotUtils.GetPathFileChat);
end;

procedure TDelphiCopilotChatView.cBoxSizeFontKeyPress(Sender: TObject; var Key: Char);
begin
  if not(CharInSet(Key, ['0'..'9', #8]))then
    key := #0;
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
  //API_URL = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=%s';
  API_URL = 'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=%s';
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
    Self.InternalAdd('Question cannot be answered');
    Self.InternalAdd('Return: ' + LResponse.Content);
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
        mmReturn.Lines.Text := TDelphiCopilotUtils.ConfReturnAI(JsonText);
      end;
    end;
  end;
end;

procedure TDelphiCopilotChatView.Last;
begin
  SendMessage(mmReturn.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

function TDelphiCopilotChatView.GetSelectedTextOrAll: string;
begin
  if not mmReturn.SelText.Trim.IsEmpty then
    Result := mmReturn.SelText
  else
    Result := mmReturn.Lines.Text;
end;

procedure TDelphiCopilotChatView.btnCopyClick(Sender: TObject);
begin
  Clipboard.AsText := Self.GetSelectedTextOrAll;
end;

procedure TDelphiCopilotChatView.btnInsertAtCursorClick(Sender: TObject);
begin
  TDelphiCopilotUtilsOTA.DeleteBlockTextSelectedInEditor;
  TDelphiCopilotUtilsOTA.InsertBlockTextIntoEditor(Self.GetSelectedTextOrAll);
end;

initialization

finalization
  Unregister;

end.
