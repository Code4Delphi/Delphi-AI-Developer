unit DelphiAIDev.DB.Chat.View;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Classes,
  System.JSON,
  System.Threading,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  System.ImageList,
  Vcl.ImgList,
  DockForm,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Menus,
  Vcl.Buttons,
  Winapi.Windows,
  Winapi.Messages,
  Clipbrd,
  DelphiAIDev.Types,
  DelphiAIDev.Consts,
  DelphiAIDev.AI,
  DelphiAIDev.Settings,
  DelphiAIDev.ModuleCreator,
  DelphiAIDev.DefaultsQuestions.PopupMenu,
  DelphiAIDev.Chat.ProcessResponse,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  DelphiAIDev.DB.Registers.Model,
  DelphiAIDev.DB.Registers.Fields,
  C4D.Conn,
  DelphiAIDev.Utils.DBGrids,
  DelphiAIDev.Projects.Model,
  DelphiAIDev.DB.References.View;

type
  TDelphiAIDevDBChatView = class(TDockableForm)
    ImageList1: TImageList;
    pMenuMemoReturn: TPopupMenu;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    SelectAll1: TMenuItem;
    pnBack: TPanel;
    pnBackQuestion: TPanel;
    mmQuestion: TMemo;
    N1: TMenuItem;
    mmReturn: TRichEdit;
    Splitter1: TSplitter;
    pnWait: TPanel;
    ShapeWait: TShape;
    pnWaitCaption: TPanel;
    pMenuCurrentAI: TPopupMenu;
    Gemini1: TMenuItem;
    ChatGPT1: TMenuItem;
    pnBackButtonsSearch: TPanel;
    lbCurrentAI: TLabel;
    StatusBar1: TStatusBar;
    pnCommands: TPanel;
    btnCopy: TSpeedButton;
    btnInsertAtCursor: TSpeedButton;
    btnMoreActions: TSpeedButton;
    ShapeCommands: TShape;
    btnSend: TButton;
    pMenuMoreActions: TPopupMenu;
    SaveContentToFile1: TMenuItem;
    btnCreateNewUnit: TSpeedButton;
    Clear1: TMenuItem;
    N2: TMenuItem;
    WordWrap1: TMenuItem;
    pnBackConfigurableButtons: TPanel;
    btnUseCurrentUnitCode: TButton;
    btnCodeOnly: TButton;
    btnDefaultsQuestions: TButton;
    pMenuQuestions: TPopupMenu;
    btnCleanAll: TSpeedButton;
    Groq1: TMenuItem;
    pnGridBack: TPanel;
    DBGrid1: TDBGrid;
    Splitter2: TSplitter;
    DataSource1: TDataSource;
    pMenuGrid: TPopupMenu;
    CopyCurrentColumn1: TMenuItem;
    CopyCurrentLine1: TMenuItem;
    CopyAllGridData: TMenuItem;
    N3: TMenuItem;
    SaveAllGridDataAsCSV: TMenuItem;
    SaveAllGridDataAsTXT: TMenuItem;
    Panel1: TPanel;
    btnExecuteSQL: TButton;
    cBoxDatabases: TComboBox;
    Label1: TLabel;
    lbLastGeneration: TLabel;
    Panel9: TPanel;
    lbCount: TLabel;
    Label3: TLabel;
    Ollama1: TMenuItem;
    btnGenerateDatabaseReference: TButton;
    procedure FormShow(Sender: TObject);
    procedure cBoxSizeFontKeyPress(Sender: TObject; var Key: Char);
    procedure Cut1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSendClick(Sender: TObject);
    procedure mmQuestionKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCopyClick(Sender: TObject);
    procedure btnInsertAtCursorClick(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure mmQuestionChange(Sender: TObject);
    procedure mmQuestionKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure lbCurrentAIClick(Sender: TObject);
    procedure Gemini1Click(Sender: TObject);
    procedure pMenuCurrentAIPopup(Sender: TObject);
    procedure btnMoreActionsClick(Sender: TObject);
    procedure SaveContentToFile1Click(Sender: TObject);
    procedure btnCreateNewUnitClick(Sender: TObject);
    procedure btnUseCurrentUnitCodeClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure WordWrap1Click(Sender: TObject);
    procedure btnCodeOnlyClick(Sender: TObject);
    procedure btnDefaultsQuestionsClick(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure btnCleanAllClick(Sender: TObject);
    procedure btnExecuteSQLClick(Sender: TObject);
    procedure cBoxDatabasesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure CopyCurrentColumn1Click(Sender: TObject);
    procedure CopyCurrentLine1Click(Sender: TObject);
    procedure CopyAllGridDataClick(Sender: TObject);
    procedure SaveAllGridDataAsCSVClick(Sender: TObject);
    procedure SaveAllGridDataAsTXTClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure btnGenerateDatabaseReferenceClick(Sender: TObject);
  private
    FAI: TDelphiAIDevAI;
    FSettings: TDelphiAIDevSettings;
    FProcessResponse: TDelphiAIDevChatProcessResponse;
    FPopupMenuQuestions: TDelphiAIDevDefaultsQuestionsPopupMenu;
    FbtnUseCurrentUnitCodeWidth: Integer;
    FbtnCodeOnlyWidth: Integer;
    FbtnDefaultsQuestionsWidth: Integer;
    FQuestionOnShow: string;
    FConn: IC4DConn;
    FQueryExecuteSQL: IC4DConnQuery;
    procedure FillMemoReturnWithFile;
    procedure SaveMemoReturnInFile;
    procedure InitializeRichEditReturn;
    procedure ProcessSend;
    procedure AddResponseSimple(const AString: string);
    procedure Last;
    function GetSelectedTextOrAllFromReturn: string;
    function GetSelectedTextOrAllOrAbort: string;
    procedure WaitingFormOFF;
    procedure WaitingFormON;
    procedure ConfLabelCurrentAI;
    procedure ConfScreenOnShow;
    procedure ChangeUseCurrentUnitCode;
    procedure ChangeCodeOnly;
    procedure AddItemsPopupMenuQuestion;
    procedure DoProcessClickInItemDefaultQuestions(ACodeOnly: Boolean; AQuestion: string);
    procedure ProcessWordWrap;
    procedure ConfScreenOnCreate;
    procedure ReloadDatabases;
    procedure FillDateLastReferences;
    function GetFieldDBSelected: TDelphiAIDevDBRegistersFields;
    function GetJsonDatabase: string;
    procedure HandleErrorExecutingSQLCommand(const E: Exception);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property QuestionOnShow: string write FQuestionOnShow;
  end;

var
  DelphiAIDevDBChatView: TDelphiAIDevDBChatView;

procedure RegisterSelf;
procedure Unregister;
procedure DelphiAIDevDBChatViewShowDockableForm;

implementation

uses
  DeskUtil,
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA,
  DelphiAIDev.DB.Utils;

{$R *.dfm}

const
  UseCurrentUnitCode_ImageIndex_OFF = 0;
  UseCurrentUnitCode_ImageIndex_ON = 1;
  CodeOnly_ImageIndex_OFF = 2;
  CodeOnly_ImageIndex_ON = 3;

procedure RegisterSelf;
begin
  if not Assigned(DelphiAIDevDBChatView) then
    DelphiAIDevDBChatView := TDelphiAIDevDBChatView.Create(nil);

  if @RegisterFieldAddress <> nil then
    RegisterFieldAddress(DelphiAIDevDBChatView.Name, @DelphiAIDevDBChatView);

  RegisterDesktopFormClass(TDelphiAIDevDBChatView, DelphiAIDevDBChatView.Name, DelphiAIDevDBChatView.Name);
end;

procedure Unregister;
begin
  if @UnRegisterFieldAddress <> nil then
    UnRegisterFieldAddress(@DelphiAIDevDBChatView);
  FreeAndNil(DelphiAIDevDBChatView);
end;

procedure DelphiAIDevDBChatViewShowDockableForm;
begin
  ShowDockableForm(DelphiAIDevDBChatView);
  FocusWindow(DelphiAIDevDBChatView);
end;

constructor TDelphiAIDevDBChatView.Create(AOwner: TComponent);
begin
  inherited;
  DeskSection := Self.Name;
  AutoSave := True;
  SaveStateNecessary := True;

  FAI := TDelphiAIDevAI.Create;
  FSettings := TDelphiAIDevSettings.GetInstance;
  FProcessResponse := TDelphiAIDevChatProcessResponse.Create(mmReturn);
  FPopupMenuQuestions := TDelphiAIDevDefaultsQuestionsPopupMenu.Create;
  FQuestionOnShow := '';

  FConn := TC4DConn.New;
  FQueryExecuteSQL := FConn.Query.DataSource(DataSource1);

  Self.ConfScreenOnCreate;
  Self.FillMemoReturnWithFile;
end;

destructor TDelphiAIDevDBChatView.Destroy;
begin
  Self.SaveMemoReturnInFile;
  FPopupMenuQuestions.Free;
  FProcessResponse.Free;
  FAI.Free;
  inherited;
end;

procedure TDelphiAIDevDBChatView.FormShow(Sender: TObject);
begin
  Self.ConfScreenOnShow;
  Self.InitializeRichEditReturn;
  Self.ProcessWordWrap;
  Self.AddItemsPopupMenuQuestion;
  TUtils.MemoFocusOnTheEnd(mmQuestion);
  Self.ReloadDatabases;
end;

procedure TDelphiAIDevDBChatView.FormActivate(Sender: TObject);
begin
  Self.ConfLabelCurrentAI;

  if not FQuestionOnShow.Trim.IsEmpty then
  begin
    mmQuestion.Lines.Clear;
    mmQuestion.Lines.Add(FQuestionOnShow);
    FQuestionOnShow := '';
  end;
end;

procedure TDelphiAIDevDBChatView.FormCreate(Sender: TObject);
begin
  TUtilsDBGrids.ConfDBGrid(DBGrid1);
end;

procedure TDelphiAIDevDBChatView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.WaitingFormOFF;
end;

procedure TDelphiAIDevDBChatView.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;  State: TGridDrawState);
begin
  TUtilsDBGrids.DrawColumnCell(TDBGrid(Sender), Rect, DataCol, Column, Vcl.Grids.TGridDrawState(State));
end;

procedure TDelphiAIDevDBChatView.ConfScreenOnCreate;
begin
  mmReturn.Lines.Clear;

  pnWait.Visible := False;
  FbtnUseCurrentUnitCodeWidth := btnUseCurrentUnitCode.Width;
  FbtnCodeOnlyWidth := btnCodeOnly.Width;
  FbtnDefaultsQuestionsWidth := btnDefaultsQuestions.Width;

  ShapeCommands.Left := 0;
  ShapeCommands.Top := 0;
  ShapeCommands.Width := ShapeCommands.Parent.Width;
  ShapeCommands.Height := ShapeCommands.Parent.Height;
end;

procedure TDelphiAIDevDBChatView.ConfScreenOnShow;
begin
  TUtilsOTA.IDEThemingAll(TDelphiAIDevDBChatView, Self);
  btnMoreActions.Font.Color := TUtilsOTA.ActiveThemeColorDefault;

  Self.Constraints.MinWidth := 200;
  Self.Constraints.MinHeight := 300;
end;

procedure TDelphiAIDevDBChatView.AddItemsPopupMenuQuestion;
begin
  FPopupMenuQuestions
    .ProcessClickInItem(DoProcessClickInItemDefaultQuestions)
    .CreateMenus(pMenuQuestions);
end;

procedure TDelphiAIDevDBChatView.DoProcessClickInItemDefaultQuestions(ACodeOnly: Boolean; AQuestion: string);
begin
  if ACodeOnly then
    btnCodeOnly.ImageIndex := CodeOnly_ImageIndex_ON
  else
    btnCodeOnly.ImageIndex := CodeOnly_ImageIndex_OFF;

  mmQuestion.Lines.Add(AQuestion);
end;

procedure TDelphiAIDevDBChatView.mmQuestionChange(Sender: TObject);
begin
  if mmQuestion.Lines.Count >= 7 then
    mmQuestion.ScrollBars := ssVertical
  else
    mmQuestion.ScrollBars := ssNone;
end;

procedure TDelphiAIDevDBChatView.mmQuestionKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift)and(Key = VK_RETURN) then
  begin
    btnSend.Click;
    Key := 0;
  end
end;

procedure TDelphiAIDevDBChatView.mmQuestionKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = 65) then
  begin
    mmQuestion.SelectAll;
    Key := 0;
  end;
end;

procedure TDelphiAIDevDBChatView.FormResize(Sender: TObject);
var
  LWidth: Integer;
const
  CAPTION_UseCurrentUnitCode = 'Use current unit code in query';
  CAPTION_CodeOnly = 'SQL only';
  CAPTION_DefaultsQuestions = 'Questions';
begin
  if Self.Width > 620 then
  begin
    btnUseCurrentUnitCode.Caption := CAPTION_UseCurrentUnitCode;
    btnUseCurrentUnitCode.Width := FbtnUseCurrentUnitCodeWidth;
    btnUseCurrentUnitCode.ImageAlignment := TImageAlignment.iaLeft;

    btnCodeOnly.Caption := CAPTION_CodeOnly;
    btnCodeOnly.Width := FbtnCodeOnlyWidth;
    btnCodeOnly.ImageAlignment := TImageAlignment.iaLeft;

    btnDefaultsQuestions.Caption := CAPTION_DefaultsQuestions;
    btnDefaultsQuestions.Width := FbtnDefaultsQuestionsWidth;
    btnDefaultsQuestions.ImageAlignment := TImageAlignment.iaLeft;
  end
  else
  begin
    LWidth := btnSend.Width;
    if Self.Width < 405 then
      LWidth := 24;

    btnUseCurrentUnitCode.Caption := '';
    btnUseCurrentUnitCode.Width := LWidth;
    btnUseCurrentUnitCode.ImageAlignment := TImageAlignment.iaCenter;

    btnCodeOnly.Caption := '';
    btnCodeOnly.Width := LWidth;
    btnCodeOnly.ImageAlignment := TImageAlignment.iaCenter;

    btnDefaultsQuestions.Caption := '';
    btnDefaultsQuestions.Width := LWidth;
    btnDefaultsQuestions.ImageAlignment := TImageAlignment.iaCenter;
  end;
end;

procedure TDelphiAIDevDBChatView.FillMemoReturnWithFile;
begin
  if FileExists(TUtils.GetPathFileChatDB) then
    mmReturn.Lines.LoadFromFile(TUtils.GetPathFileChatDB)
end;

procedure TDelphiAIDevDBChatView.SaveMemoReturnInFile;
begin
  mmReturn.Lines.SaveToFile(TUtils.GetPathFileChatDB);
end;

procedure TDelphiAIDevDBChatView.SelectAll1Click(Sender: TObject);
begin
  mmReturn.SelectAll;
end;

procedure TDelphiAIDevDBChatView.cBoxSizeFontKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8]) then
    Key := #0;
end;

procedure TDelphiAIDevDBChatView.Cut1Click(Sender: TObject);
begin
  mmReturn.CutToClipboard;
end;

procedure TDelphiAIDevDBChatView.Copy1Click(Sender: TObject);
begin
  mmReturn.CopyToClipboard;
end;

procedure TDelphiAIDevDBChatView.Paste1Click(Sender: TObject);
begin
  mmReturn.PasteFromClipboard;
end;

procedure TDelphiAIDevDBChatView.btnUseCurrentUnitCodeClick(Sender: TObject);
begin
  Self.ChangeUseCurrentUnitCode;
end;

procedure TDelphiAIDevDBChatView.btnDefaultsQuestionsClick(Sender: TObject);
begin
  pMenuQuestions.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TDelphiAIDevDBChatView.ChangeUseCurrentUnitCode;
begin
  if btnUseCurrentUnitCode.ImageIndex = UseCurrentUnitCode_ImageIndex_OFF then
    btnUseCurrentUnitCode.ImageIndex := UseCurrentUnitCode_ImageIndex_ON
  else
    btnUseCurrentUnitCode.ImageIndex := UseCurrentUnitCode_ImageIndex_OFF;
end;

procedure TDelphiAIDevDBChatView.btnCodeOnlyClick(Sender: TObject);
begin
  Self.ChangeCodeOnly;
end;

procedure TDelphiAIDevDBChatView.ChangeCodeOnly;
begin
  if btnCodeOnly.ImageIndex = CodeOnly_ImageIndex_OFF then
    btnCodeOnly.ImageIndex := CodeOnly_ImageIndex_ON
  else
    btnCodeOnly.ImageIndex := CodeOnly_ImageIndex_OFF;
end;

procedure TDelphiAIDevDBChatView.ReloadDatabases;
var
  LGuidDatabaseDefault: string;
begin
  LGuidDatabaseDefault := TDelphiAIDevProjectsModel.New.ReadFilePathCurrentProject.GuidDatabaseDefault;

  TDelphiAIDevDBUtils.FillComboBoxDataBases(cBoxDatabases, LGuidDatabaseDefault);
  Self.FillDateLastReferences;
end;

procedure TDelphiAIDevDBChatView.AddResponseSimple(const AString: string);
begin
  Self.Last;
  mmReturn.SelAttributes.Color := TUtilsOTA.ActiveThemeColorDefault;
  mmReturn.SelAttributes.Style := [];
  mmReturn.Lines.Add(AString);
  Self.Last;
end;

procedure TDelphiAIDevDBChatView.WaitingFormON;
begin
  pnWait.Visible := False;
  TUtils.CenterPanel(pnWait, mmReturn);
  pnWait.Visible := True;
end;

procedure TDelphiAIDevDBChatView.WordWrap1Click(Sender: TObject);
begin
  Self.ProcessWordWrap;
end;

procedure TDelphiAIDevDBChatView.ProcessWordWrap;
begin
  if WordWrap1.Checked then
    mmReturn.ScrollBars := ssVertical
  else
    mmReturn.ScrollBars := ssBoth;
end;

procedure TDelphiAIDevDBChatView.WaitingFormOFF;
begin
  pnWait.Visible := False;
end;

procedure TDelphiAIDevDBChatView.Last;
begin
  SendMessage(mmReturn.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TDelphiAIDevDBChatView.lbCurrentAIClick(Sender: TObject);
begin
  pMenuCurrentAI.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

function TDelphiAIDevDBChatView.GetSelectedTextOrAllFromReturn: string;
begin
  if not mmReturn.SelText.Trim.IsEmpty then
    Result := mmReturn.SelText
  else
    Result := mmReturn.Lines.Text;
end;

function TDelphiAIDevDBChatView.GetSelectedTextOrAllOrAbort: string;
begin
  Result := Self.GetSelectedTextOrAllFromReturn;
  if Result.Trim.IsEmpty then
    TUtils.ShowMsgAndAbort('There is no data to be used in this action');
end;

procedure TDelphiAIDevDBChatView.btnInsertAtCursorClick(Sender: TObject);
var
 LText: string;
begin
  LText := Self.GetSelectedTextOrAllOrAbort;
  TUtilsOTA.DeleteBlockTextSelectedInEditor;
  TUtilsOTA.InsertBlockTextIntoEditor(LText);
end;

procedure TDelphiAIDevDBChatView.btnCopyClick(Sender: TObject);
var
 LText: string;
begin
  LText := Self.GetSelectedTextOrAllOrAbort;
  Clipboard.AsText := LText;
end;

procedure TDelphiAIDevDBChatView.btnCreateNewUnitClick(Sender: TObject);
var
 LText: string;
begin
  LText := Self.GetSelectedTextOrAllOrAbort;
  TDelphiAIDevModuleCreator.New.CreateNewUnit(LText);
end;

procedure TDelphiAIDevDBChatView.SaveContentToFile1Click(Sender: TObject);
var
  LFileName: string;
begin
  Self.GetSelectedTextOrAllOrAbort;

  LFileName := TUtils.GetFileName('rtf');
  mmReturn.Lines.SaveToFile(LFileName);
  TUtils.ShowV('File saved successfully');
end;

procedure TDelphiAIDevDBChatView.Clear1Click(Sender: TObject);
begin
  mmReturn.Lines.Clear;
end;

procedure TDelphiAIDevDBChatView.btnMoreActionsClick(Sender: TObject);
begin
  pMenuMoreActions.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TDelphiAIDevDBChatView.InitializeRichEditReturn;
begin
  mmReturn.SelAttributes.Name := 'Courier New';
  mmReturn.SelAttributes.Size := 10;

  if TUtilsOTA.ActiveThemeIsDark then
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

procedure TDelphiAIDevDBChatView.pMenuCurrentAIPopup(Sender: TObject);
begin
  Gemini1.Checked := False;
  ChatGPT1.Checked := False;
  Groq1.Checked := False;
  Ollama1.Checked := False;
  case FSettings.AIDefault of
    TC4DAiAvailable.Gemini:
      Gemini1.Checked := True;
    TC4DAiAvailable.OpenAI:
      ChatGPT1.Checked := True;
    TC4DAiAvailable.Groq:
      Groq1.Checked := True;
    TC4DAiAvailable.Ollama:
      Ollama1.Checked := True;
  end;
end;

procedure TDelphiAIDevDBChatView.ConfLabelCurrentAI;
begin
  lbCurrentAI.Caption := FSettings.AIDefault.ToString;

  case FSettings.AIDefault of
    TC4DAiAvailable.Gemini:
      lbCurrentAI.Hint := FSettings.ModelGemini;
    TC4DAiAvailable.OpenAI:
      lbCurrentAI.Hint := FSettings.ModelOpenAI;
    TC4DAiAvailable.Groq:
      lbCurrentAI.Hint := FSettings.ModelGroq;
    TC4DAiAvailable.Ollama:
      lbCurrentAI.Hint := FSettings.ModelOllama;
  end;

  lbCurrentAI.Repaint;
  Self.Repaint;
end;

procedure TDelphiAIDevDBChatView.Gemini1Click(Sender: TObject);
var
  LTag: Integer;
begin
  //*SEVERAL
  LTag := TMenuItem(Sender).Tag;
  if not(LTag in [0, 1, 2, 3])then
    Exit;

  FSettings.AIDefault := TC4DAiAvailable(LTag);
  FSettings.SaveData;
  Self.ConfLabelCurrentAI;
end;

procedure TDelphiAIDevDBChatView.btnCleanAllClick(Sender: TObject);
begin
  mmQuestion.Lines.Clear;
  mmReturn.Lines.Clear;
end;

procedure TDelphiAIDevDBChatView.cBoxDatabasesClick(Sender: TObject);
begin
  Self.FillDateLastReferences;
end;

procedure TDelphiAIDevDBChatView.FillDateLastReferences;
begin
  lbLastGeneration.Caption := '';

  if cBoxDatabases.Items.Count < 0 then
    Exit;

  lbLastGeneration.Caption := TUtils.DateTimeToStrEmpty(Self.GetFieldDBSelected.LastReferences);
end;

procedure TDelphiAIDevDBChatView.btnGenerateDatabaseReferenceClick(Sender: TObject);
var
  LView: TDelphiAIDevDBReferencesView;
  LFields: TDelphiAIDevDBRegistersFields;
begin
  if cBoxDatabases.Items.Count < 0 then
    Exit;

  LFields := Self.GetFieldDBSelected;
  if LFields = nil then
    Exit;

  LView := TDelphiAIDevDBReferencesView.Create(nil);
  try
    LView.Fields := LFields;
    if LView.ShowModal = mrOk then
      Self.FillDateLastReferences;
  finally
    LView.Free;
  end;
end;


function TDelphiAIDevDBChatView.GetFieldDBSelected: TDelphiAIDevDBRegistersFields;
begin
  Result := TDelphiAIDevDBRegistersFields(cBoxDatabases.Items.Objects[cBoxDatabases.ItemIndex]);
end;

procedure TDelphiAIDevDBChatView.btnSendClick(Sender: TObject);
begin
  Self.ProcessSend;
end;

procedure TDelphiAIDevDBChatView.ProcessSend;
var
  LTask: ITask;
  LQuestion: string;
begin
  if mmQuestion.Lines.Text.Trim.IsEmpty then
    TUtils.ShowMsgAndAbort('No questions have been added', mmQuestion);

  FSettings.ValidateFillingSelectedAI;

  mmReturn.Lines.Clear;
  Self.WaitingFormON;

  LQuestion := FSettings.LanguageQuestions.GetLanguageDefinition;

  if btnUseCurrentUnitCode.ImageIndex = UseCurrentUnitCode_ImageIndex_ON then
    LQuestion := TUtilsOTA.GetSelectedBlockOrAllCodeUnit.Trim + sLineBreak;

  if btnCodeOnly.ImageIndex = CodeOnly_ImageIndex_ON then
    LQuestion := LQuestion + FSettings.LanguageQuestions.GetMsgSQLOnly + sLineBreak;

  LQuestion := LQuestion + FSettings.LanguageQuestions.GetMsgJSONIsDatabaseStructure(Self.GetFieldDBSelected.DriverID.ToString);
  LQuestion := LQuestion + Self.GetJsonDatabase + sLineBreak;
  LQuestion := LQuestion + FSettings.LanguageQuestions.GetMsgJSONInformedAnswerQuestion;
  LQuestion := LQuestion + mmQuestion.Lines.Text;

  LTask := TTask.Create(
    procedure
    begin
      try
        try
          FAI.AiUse(FSettings.AIDefault).ProcessSend(LQuestion);
        except
          on E: Exception do
            TThread.Synchronize(nil,
              procedure
              begin
                Self.AddResponseSimple('Unable to perform processing.' + sLineBreak + TUtils.GetExceptionMessage(E));
                Abort;
              end);
        end;

        TThread.Synchronize(nil,
          procedure
          begin
            mmReturn.Lines.BeginUpdate;
            try
              //Optional use of one of the following lines
              FProcessResponse.AddResponseComplete(FAI.Response);
              Self.Last;
              //Self.AddResponseSimple(FChat.Response.Text);
            finally
              mmReturn.Lines.EndUpdate;
            end;
          end);
      finally
        TThread.Synchronize(nil,
          procedure
          begin
            Self.WaitingFormOFF;
          end);
      end;
    end);
  LTask.Start;
end;

function TDelphiAIDevDBChatView.GetJsonDatabase: string;
var
  LFileName: string;
  LStringList: TStringList;
begin
  LFileName := TUtils.GetPathFolderMetaInfo + Self.GetFieldDBSelected.Guid + '.json';

  if not FileExists(LFileName) then
    TUtils.ShowMsgAndAbort('File with database structure not found', LFileName);

  LStringList := TStringList.Create;
  try
    LStringList.LoadFromFile(LFileName);
    Result := LStringList.Text;
  finally
    LStringList.Free;
  end;
end;

procedure TDelphiAIDevDBChatView.btnExecuteSQLClick(Sender: TObject);
var
  LCommand: string;
  LField: TDelphiAIDevDBRegistersFields;
begin
  LCommand := Trim(mmReturn.Lines.Text);
  if LCommand.IsEmpty then
    TUtils.ShowMsgAndAbort('No SQL command informed');

  Screen.Cursor := crHourGlass;
  try
    lbCount.Caption := '000000';
    LField := Self.GetFieldDBSelected;

    FConn.Configs
      .DriverID(LField.DriverID)
      .Host(LField.Host)
      .UserName(LField.User)
      .Password(LField.Password)
      .Port(LField.Port)
      .Database(LField.DatabaseName)
      .VendorLib(LField.VendorLib);

    try
      if not FConn.Connection.TestConnection then
        TUtils.ShowMsgAndAbort('Connection refused');
    except
      on E: exception do
        TUtils.ShowMsgErrorAndAbort(E.Message);
    end;

    try
      FQueryExecuteSQL.CloseClear.Add(LCommand).Open;
    except
      on E: Exception do
        Self.HandleErrorExecutingSQLCommand(E);
    end;

    lbCount.Caption := FQueryExecuteSQL.RecordCountStr;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TDelphiAIDevDBChatView.HandleErrorExecutingSQLCommand(const E: Exception);
var
  LCommand: string;
  LMsg: string;
begin
  LCommand := Trim(mmReturn.Lines.Text).ToLower;
  LMsg := 'Unable to execute command.';

  if LCommand.Contains('insert') then
    LMsg := LMsg + sLineBreak + 'Insert commands are blocked';

  if LCommand.Contains('update') then
    LMsg := LMsg + sLineBreak + 'Update commands are blocked';

  if LCommand.Contains('delete') then
    LMsg := LMsg + sLineBreak + 'Delete commands are blocked';

  if LCommand.Contains('drop') then
    LMsg := LMsg + sLineBreak + 'Drop commands are blocked';

  if LCommand.Contains('create') then
    LMsg := LMsg + sLineBreak + 'Create commands are blocked';

  if LMsg.Trim.IsEmpty then
    LMsg := LMsg + sLineBreak + E.Message;

  TUtils.ShowMsgErrorAndAbort(LMsg.Trim, E.Message);
end;

procedure TDelphiAIDevDBChatView.CopyCurrentColumn1Click(Sender: TObject);
begin
  TUtilsDBGrids.DBGridToClipboardCurrentColumn(DBGrid1);
end;

procedure TDelphiAIDevDBChatView.CopyCurrentLine1Click(Sender: TObject);
begin
  TUtilsDBGrids.DBGridToClipboardCurrentLine(DBGrid1);
end;

procedure TDelphiAIDevDBChatView.CopyAllGridDataClick(Sender: TObject);
begin
  TUtilsDBGrids.DBGridToClipboardAll(DBGrid1);
end;

procedure TDelphiAIDevDBChatView.SaveAllGridDataAsCSVClick(Sender: TObject);
begin
  TUtilsDBGrids.DBGridToCSV(DBGrid1);
  TUtils.ShowV('File saved successfully');
end;

procedure TDelphiAIDevDBChatView.SaveAllGridDataAsTXTClick(Sender: TObject);
begin
  TUtilsDBGrids.DBGridToTxt(DBGrid1);
  TUtils.ShowV('File saved successfully');
end;

procedure TDelphiAIDevDBChatView.DBGrid1TitleClick(Column: TColumn);
var
  LCampo: string;
  LOrdem: string;
begin
  if DataSource1.DataSet.IsEmpty then
    Exit;

  LCampo := Column.FieldName.Trim;
  if (LCampo.IsEmpty) or (Column.Field.FieldKind = fkCalculated) then
    Exit;

  LOrdem := LCampo + ':D';
  if FQueryExecuteSQL.IndexFieldNames.Contains(':D') then
    LOrdem := LCampo;

  FQueryExecuteSQL.IndexFieldNames(LOrdem);
end;

initialization

finalization
  Unregister;

end.
