unit DelphiCopilot.Utils.OTA;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Variants,
  System.Generics.Collections,
  Winapi.Windows,
  Vcl.Forms,
  Vcl.ExtCtrls,
  Vcl.Graphics,
  ToolsAPI,
  DelphiCopilot.Types;

type
  TDelphiCopilotUtilsOTA = class
  private
    class function EditorAsString(AIOTAModule: IOTAModule): string;
  public
    class function CurrentProjectIsC4DWizardDPROJ: Boolean;
    class function CurrentModuleIsReadOnly: Boolean;
    class procedure SaveAllModifiedModules;
    class function AddImgIDEResourceName(AResourceName: string): Integer;
    class function AddImgIDEFilePath(AFilePath: string): Integer;
    class function EditorAsStringList(AIOTAModule: IOTAModule): TStringList;
    class procedure DeleteBlockTextSelectedInEditor;
    class procedure InsertBlockTextIntoEditor(const AText: string);
    class function OTAFileNotificationToC4DWizardFileNotification(AOTAFileNotification: TOTAFileNotification): TDelphiCopilotFileNotification;
    class procedure OpenFilePathInIDE(AFilePath: string);
    class procedure ShowFormProjectOptions;
    class function RefreshProject: Boolean;
    class function RefreshModule: Boolean;
    class procedure RefreshProjectOrModule;
    class function FileIsOpenInIDE(const APathFile: string): Boolean;
    class function CheckIfExistFileInCurrentsProjectGroups(const ANameFileWithExtension: string): Boolean;
    class procedure IDEThemingAll(AFormClass: TCustomFormClass; AForm: TForm);
    class function ActiveThemeColorDefaul: TColor;
    class function ActiveThemeIsDark: Boolean;
    class function GetIOTAFormEditor(const AIOTAModule: IOTAModule): IOTAFormEditor;
    {$IF CompilerVersion >= 32.0} //Tokyo
    class function GetIOTAIDEThemingServices: IOTAIDEThemingServices;
    class function GetIOTAIDEThemingServices250: IOTAIDEThemingServices250;
    {$ENDIF}
    class function GetIOTACompileServices: IOTACompileServices;
    class function GetIOTAWizardServices: IOTAWizardServices;
    class function GetIOTAEditView(AIOTAModule: IOTAModule): IOTAEditView; overload;
    class function GetIOTAEditView(AIOTASourceEditor: IOTASourceEditor): IOTAEditView; overload;
    ///<summary> Get the active source editor (Tab selected in editor) </summary>
    class function GetIOTASourceEditor(AIOTAModule: IOTAModule): IOTASourceEditor; overload;
    ///<summary> Get the active source editor (Tab selected in editor) </summary>
    class function GetIOTASourceEditor(AIOTAEditor: IOTAEditor): IOTASourceEditor; overload;
    ///<summary> Get the active source editor (Tab selected in editor) </summary>
    class function GetIOTASourceEditor(AIOTAModule: IOTAModule; const AFileName: string): IOTASourceEditor; overload;
    class function GetIOTAEditBufferCurrentModule: IOTAEditBuffer;
    class function GetIOTAEditBuffer(AIOTAModule: IOTAModule): IOTAEditBuffer;
    class function GetIOTAMessageServices: IOTAMessageServices;
    class function GetIOTAProjectManager: IOTAProjectManager;
    class function GetIOTAKeyboardServices: IOTAKeyboardServices;
    class function GetIOTAServices: IOTAServices;
    class function GetIOTAActionServices: IOTAActionServices;
    class function GetINTAServices: INTAServices;
    class function GetIOTAModuleServices: IOTAModuleServices;
    class function GetIOTAEditorServices: IOTAEditorServices;
    class function GetBlockTextSelect: string;
    class function GetCurrentModule: IOTAModule;
    class function GetCurrentModuleFileName: string;
    class function GetModule(const AFileName: string): IOTAModule;
    class function GetCurrentProjectGroup: IOTAProjectGroup;
    class function GetCurrentProject: IOTAProject;
    class function GetCurrentProjectFileName: string;
    class function GetProjectName(const AIOTAProject: IOTAProject): string;
    class function GetFileNameDprOrDpkIfDproj(const AIOTAModule: IOTAModule): string;
    class function GetCurrentProjectOptions: IOTAProjectOptions;
    class function GetCurrentOutputDir: string;
    class function GetCurrentProjectOptionsConfigurations: IOTAProjectOptionsConfigurations;
    class function GetPathsFilesOpened: TList<string>;
    class procedure GetAllFilesFromProjectGroup(AListFiles: TStrings;
      const AFilePathProjectOrGroupForFilter: string;
      const AC4DWizardExtensions: TC4DExtensionsOfFiles);
  end;

implementation

uses
  DelphiCopilot.Consts,
  DelphiCopilot.Utils;

class function TDelphiCopilotUtilsOTA.CurrentProjectIsC4DWizardDPROJ: Boolean;
var
  LIOTAProject: IOTAProject;
begin
  Result := False;

  LIOTAProject := Self.GetCurrentProject;
  if(LIOTAProject = nil)then
    Exit;

  Result := TDelphiCopilotUtils.FileNameIsC4DWizardDPROJ(LIOTAProject.FileName);
end;

class function TDelphiCopilotUtilsOTA.CurrentModuleIsReadOnly: Boolean;
var
  LIOTAEditBuffer: IOTAEditBuffer;
begin
  Result := False;

  LIOTAEditBuffer := Self.GetIOTAEditBufferCurrentModule;
  if(LIOTAEditBuffer = nil)then
    Exit;

  Result := LIOTAEditBuffer.IsReadOnly;
end;

class procedure TDelphiCopilotUtilsOTA.SaveAllModifiedModules;
var
  LIOTAModuleServices: IOTAModuleServices;
  I: Integer;
  LIOTAModule: IOTAModule;
  LIOTAEditor: IOTAEditor;
begin
  LIOTAModuleServices := Self.GetIOTAModuleServices;
  for I := 0 to Pred(LIOTAModuleServices.ModuleCount) do
  begin
    LIOTAModule := LIOTAModuleServices.Modules[I];
    LIOTAEditor := LIOTAModule.CurrentEditor;
    if LIOTAEditor = nil then
      continue;

    if LIOTAEditor.Modified then
      LIOTAModule.Save(False, True);
  end;
end;

class function TDelphiCopilotUtilsOTA.AddImgIDEResourceName(AResourceName: string): Integer;
var
  LBitmap: TBitmap;
  LMaskColor: TColor;
begin
  Result := -1;
  if(FindResource(hInstance, PChar(AResourceName), RT_BITMAP) <= 0)then
    Exit;

  LBitmap := TBitmap.Create;
  try
    try
      LBitmap.LoadFromResourceName(hInstance, AResourceName);
      {$IF CompilerVersion = 35} //Alexandria
        LMaskColor := clLime;
      {$ELSE}
        LMaskColor := LBitmap.TransparentColor;
      {$ENDIF}
      Result := TDelphiCopilotUtilsOTA.GetINTAServices.AddMasked(LBitmap, LMaskColor); //, AResourceName
    except
      on E: Exception do
//        LogFile
//          .AddLog('Erro em TDelphiCopilotUtilsOTA.AddImgIDEResourceName')
//          .AddLog('  AResourceName: ' + AResourceName)
//          .AddLog('  Message: ' + E.Message);
    end;
  finally
    LBitmap.Free;
  end;
end;

class function TDelphiCopilotUtilsOTA.AddImgIDEFilePath(AFilePath: string): Integer;
var
  LBitmap: TBitmap;
  LMaskColor: TColor;
begin
  Result := -1;
  LBitmap := TBitmap.Create;
  try
    try
      LBitmap.LoadFromFile(AFilePath);
      {$IF CompilerVersion = 35} //Alexandria
        LMaskColor := clLime;
      {$ELSE}
        LMaskColor := LBitmap.TransparentColor;
      {$ENDIF}
      Result := TDelphiCopilotUtilsOTA.GetINTAServices.AddMasked(LBitmap, LMaskColor); // AFilePath
    except
      on E: Exception do
//        LogFile
//          .AddLog('Erro em TDelphiCopilotUtilsOTA.AddImgIDEFilePath')
//          .AddLog('  AFilePath: ' + AFilePath)
//          .AddLog('  Message: ' + E.Message);
    end;
  finally
    LBitmap.Free;
  end;
end;

class function TDelphiCopilotUtilsOTA.EditorAsStringList(AIOTAModule: IOTAModule): TStringList;
begin
  Result := TStringList.Create;
  try
    Result.Text := Self.EditorAsString(AIOTAModule);
  except
    Result.Free;
    raise;
  end;
end;

class function TDelphiCopilotUtilsOTA.EditorAsString(AIOTAModule: IOTAModule): string;
const
  BUFFER_SIZE: Integer = 1024;
var
  LIOTAEditReader: IOTAEditReader;
  LRead: Integer;
  LPosition: Integer;
  LStrBuffer: AnsiString;
begin
  Result := '';
  LIOTAEditReader := Self.GetIOTASourceEditor(AIOTAModule).CreateReader;
  try
    LPosition := 0;
    repeat
      SetLength(LStrBuffer, BUFFER_SIZE);
      LRead := LIOTAEditReader.GetText(LPosition, PAnsiChar(LStrBuffer), BUFFER_SIZE);
      SetLength(LStrBuffer, LRead);
      Result := Result + string(UTF8Tostring(LStrBuffer));
      Inc(LPosition, LRead);
    until LRead < BUFFER_SIZE;
  finally
    LIOTAEditReader := nil;
  end;
end;

class procedure TDelphiCopilotUtilsOTA.DeleteBlockTextSelectedInEditor;
var
  LIOTAEditorServices: IOTAEditorServices;
  LIOTAEditView: IOTAEditView;
  LStartRow: Integer;
  LIOTAEditBlock: IOTAEditBlock;
  LText: string;
begin
  LIOTAEditorServices := Self.GetIOTAEditorServices;
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
end;

class procedure TDelphiCopilotUtilsOTA.InsertBlockTextIntoEditor(const AText: string);
var
  LOTAEditorServices: IOTAEditorServices;
  LIOTAEditView: IOTAEditView;
  LPosition: Longint;
  LOTACharPos: TOTACharPos;
  LOTAEditPos: TOTAEditPos;
  LIOTAEditWriter: IOTAEditWriter;
begin
  LOTAEditorServices := Self.GetIOTAEditorServices;
  LIOTAEditView := LOTAEditorServices.TopView;
  LOTAEditPos := LIOTAEditView.CursorPos;
  LIOTAEditView.ConvertPos(True, LOTAEditPos, LOTACharPos);
  LPosition := LIOTAEditView.CharPosToPos(LOTACharPos);
  LIOTAEditWriter := LOTAEditorServices.GetTopBuffer.CreateUndoableWriter;
  try
    LIOTAEditWriter.CopyTo(LPosition);
    LIOTAEditWriter.Insert(PAnsiChar(Utf8Encode(TDelphiCopilotUtils.ProcessTextForEditor(AText).TrimRight)));
  finally
    LIOTAEditWriter := nil;
  end;
  LIOTAEditView.MoveViewToCursor;
  LIOTAEditView.Paint;
end;

class function TDelphiCopilotUtilsOTA.GetBlockTextSelect: string;
var
  LIOTAEditorServices: IOTAEditorServices;
begin
  Result := '';
  LIOTAEditorServices := Self.GetIOTAEditorServices;
  if(LIOTAEditorServices.TopView <> nil)then
    Result := LIOTAEditorServices.TopView.GetBlock.Text;
end;

class function TDelphiCopilotUtilsOTA.OTAFileNotificationToC4DWizardFileNotification(AOTAFileNotification: TOTAFileNotification): TDelphiCopilotFileNotification;
begin
  Result := TDelphiCopilotFileNotification.None;
  case(AOTAFileNotification)of
    ofnFileOpened:
    Result := TDelphiCopilotFileNotification.FileOpened;
    ofnFileClosing:
    Result := TDelphiCopilotFileNotification.FileClosing;
  end;
end;

class procedure TDelphiCopilotUtilsOTA.OpenFilePathInIDE(AFilePath: string);
begin
  if(not FileExists(AFilePath))then
    Exit;

  if(TDelphiCopilotUtils.IsProject(AFilePath))then
    Self.GetIOTAActionServices.OpenProject(AFilePath, True)
  else
    Self.GetIOTAActionServices.OpenFile(AFilePath);
end;

class procedure TDelphiCopilotUtilsOTA.ShowFormProjectOptions;
begin
  GetCurrentProject.ProjectOptions.EditOptions;
end;

class function TDelphiCopilotUtilsOTA.RefreshProject: Boolean;
var
  LIOTAProject: IOTAProject;
begin
  Result := True;
  LIOTAProject := GetCurrentProject;
  if(LIOTAProject = nil)then
    Exit(False);
  LIOTAProject.Refresh(False);
end;

class function TDelphiCopilotUtilsOTA.RefreshModule: Boolean;
var
  LIOTAModule: IOTAModule;
begin
  Result := True;
  LIOTAModule := GetCurrentModule;
  if(LIOTAModule = nil)then
    Exit(False);
  LIOTAModule.Refresh(False);
end;

class procedure TDelphiCopilotUtilsOTA.RefreshProjectOrModule;
begin
  if(not Self.RefreshProject)then
    Self.RefreshModule;
end;

class function TDelphiCopilotUtilsOTA.FileIsOpenInIDE(const APathFile: string): Boolean;
var
  LIOTAModuleServices: IOTAModuleServices;
  LIOTAModule: IOTAModule;
  LIOTASourceEditor: IOTASourceEditor;
  i: Integer;
begin
  Result := False;
  if(APathFile.Trim.IsEmpty)then
    Exit;

  LIOTAModuleServices := Self.GetIOTAModuleServices;
  for i := 0 to Pred(LIOTAModuleServices.ModuleCount) do
  begin
    LIOTAModule := LIOTAModuleServices.Modules[i];

    LIOTASourceEditor := TDelphiCopilotUtilsOTA.GetIOTASourceEditor(LIOTAModule);
    if LIOTASourceEditor = nil then
      Continue;

    if LIOTASourceEditor.EditViewCount <= 0 then
      Continue;

    Result := SameFileName(APathFile, LIOTAModule.FileName);
    if(Result)then
      Exit;
  end;
end;

class function TDelphiCopilotUtilsOTA.CheckIfExistFileInCurrentsProjectGroups(const ANameFileWithExtension: string): Boolean;
var
  LIOTAModuleServices: IOTAModuleServices;
  LIOTAModuleCurrent: IOTAModule;
  LOTAProjectGroup: IOTAProjectGroup;
  LIOTAProjectCurrent: IOTAProject;
  LContModule: Integer;
  LContProject: Integer;
  LContFile: Integer;
  LFilePath: string;
begin
  Result := False;
  LIOTAModuleServices := Self.GetIOTAModuleServices;
  if(LIOTAModuleServices = nil)then
    Exit;

  if(LIOTAModuleServices.ModuleCount = 0)then
    Exit;

  for LContModule := 0 to Pred(LIOTAModuleServices.ModuleCount) do
  begin
    LIOTAModuleCurrent := LIOTAModuleServices.Modules[LContModule];
    if(ExtractFileName(LIOTAModuleCurrent.FileName) = ANameFileWithExtension)then
      Exit(True);

    if(Supports(LIOTAModuleCurrent, IOTAProjectGroup, LOTAProjectGroup))then
    begin
      for LContProject := 0 to Pred(LOTAProjectGroup.ProjectCount) do
      begin
        LIOTAProjectCurrent := LOTAProjectGroup.Projects[LContProject];
        for LContFile := 0 to Pred(LIOTAProjectCurrent.GetModuleCount) do
        begin
          LFilePath := LIOTAProjectCurrent.GetModule(LContFile).FileName;
          if(LFilePath.Trim.IsEmpty)then
            Continue;

          if(ExtractFileName(LFilePath) = ANameFileWithExtension)then
            Exit(True);
        end;
      end;
    end;
  end;
end;

class procedure TDelphiCopilotUtilsOTA.IDEThemingAll(AFormClass: TCustomFormClass; AForm: TForm);
{$IF CompilerVersion >= 32.0}
var
  i: Integer;
  LIOTAIDEThemingServices250: IOTAIDEThemingServices250;
{$ENDIF}
begin
  AForm.Constraints.MinHeight := AForm.Height;
  AForm.Constraints.MinWidth := AForm.Width;

  {$IF CompilerVersion >= 32.0}
  LIOTAIDEThemingServices250 := Self.GetIOTAIDEThemingServices250;
  LIOTAIDEThemingServices250.RegisterFormClass(AFormClass);
  LIOTAIDEThemingServices250.ApplyTheme(AForm);

  for i := 0 to Pred(AForm.ComponentCount) do
  begin
    if(AForm.Components[i] is TPanel)then
      TPanel(AForm.Components[i]).ParentBackground := True;

    LIOTAIDEThemingServices250.ApplyTheme(AForm.Components[i]);
  end
  {$ENDIF}
end;

class function TDelphiCopilotUtilsOTA.ActiveThemeColorDefaul: TColor;
begin
  Result := clWindowText;
  if(Self.ActiveThemeIsDark)then
    Result := clWhite;
end;

class function TDelphiCopilotUtilsOTA.ActiveThemeIsDark: Boolean;
const
  THEME_DARK = 'dark';
begin
  {$IF CompilerVersion >= 32.0}
    Result := Self.GetIOTAIDEThemingServices.ActiveTheme.ToLower.Equals(THEME_DARK);
  {$ELSE}
    Result := False;
  {$ENDIF}
end;

class function TDelphiCopilotUtilsOTA.GetIOTAFormEditor(const AIOTAModule: IOTAModule): IOTAFormEditor;
var
  i: Integer;
  LIOTAEditor: IOTAEditor;
  LIOTAFormEditor: IOTAFormEditor;
begin
  Result := nil;
  if(not Assigned(AIOTAModule))then
    Exit;

  for i := 0 to Pred(AIOTAModule.GetModuleFileCount) do
  begin
    LIOTAEditor := AIOTAModule.GetModuleFileEditor(i);

    if(Supports(LIOTAEditor, IOTAFormEditor, LIOTAFormEditor))then
    begin
      Result := LIOTAFormEditor;
      Break;
    end;
  end;
end;

{$IF CompilerVersion >= 32.0}

class function TDelphiCopilotUtilsOTA.GetIOTAIDEThemingServices: IOTAIDEThemingServices;
begin
  if(not Supports(BorlandIDEServices, IOTAIDEThemingServices, Result))then
    raise Exception.Create('Interface not supported: IOTAIDEThemingServices');
end;

class function TDelphiCopilotUtilsOTA.GetIOTAIDEThemingServices250: IOTAIDEThemingServices250;
begin
  if(not Supports(BorlandIDEServices, IOTAIDEThemingServices250, Result))then
    raise Exception.Create('Interface not supported: IOTAIDEThemingServices250');
end;
{$ENDIF}


class function TDelphiCopilotUtilsOTA.GetIOTACompileServices: IOTACompileServices;
begin
  if(not Supports(BorlandIDEServices, IOTACompileServices, Result))then
    raise Exception.Create('Interface not supported: IOTACompileServices');
end;

class function TDelphiCopilotUtilsOTA.GetIOTAWizardServices: IOTAWizardServices;
begin
  if(not Supports(BorlandIDEServices, IOTAWizardServices, Result))then
    raise Exception.Create('Interface not supported: IOTAWizardServices');
end;

class function TDelphiCopilotUtilsOTA.GetIOTAEditView(AIOTAModule: IOTAModule): IOTAEditView;
var
  LIOTASourceEditor: IOTASourceEditor;
  LIOTAEditView: IOTAEditView;
begin
  LIOTASourceEditor := Self.GetIOTASourceEditor(AIOTAModule);
  if(LIOTASourceEditor = nil)then
    Exit;

  LIOTAEditView := Self.GetIOTAEditView(LIOTASourceEditor);
  if(LIOTAEditView = nil)then
    Exit;
  //LIOTASourceEditor.Show;
  Result := LIOTAEditView;
end;

class function TDelphiCopilotUtilsOTA.GetIOTAEditView(AIOTASourceEditor: IOTASourceEditor): IOTAEditView;
var
  LIOTAEditBuffer: IOTAEditBuffer;
begin
  Result := nil;

  if(not Supports(AIOTASourceEditor, IOTAEditBuffer, LIOTAEditBuffer))then
    raise Exception.Create('Interface not supported: IOTAEditBuffer');

  if(LIOTAEditBuffer <> nil)then
    Result := LIOTAEditBuffer.TopView
  else if AIOTASourceEditor.EditViewCount > 0 then
    Result := AIOTASourceEditor.EditViews[0];
end;

class function TDelphiCopilotUtilsOTA.GetIOTASourceEditor(AIOTAModule: IOTAModule): IOTASourceEditor;
var
  LIOTAModule: IOTAModule;
  i: Integer;
begin
  Result := nil;
  LIOTAModule := AIOTAModule;
  for i := 0 to Pred(LIOTAModule.ModuleFileCount) do
  begin
    if(LIOTAModule.ModuleFileEditors[i].QueryInterface(IOTASourceEditor, Result) = S_OK)then
      Break;
  end;
end;

class function TDelphiCopilotUtilsOTA.GetIOTASourceEditor(AIOTAEditor: IOTAEditor): IOTASourceEditor;
begin
  Result := nil;
  if(not Supports(AIOTAEditor, IOTASourceEditor, Result))then
    raise Exception.Create('Interface not supported: IOTASourceEditor');
end;

class function TDelphiCopilotUtilsOTA.GetIOTASourceEditor(AIOTAModule: IOTAModule; const AFileName: string): IOTASourceEditor;
var
  i: Integer;
  LIOTAEditor: IOTAEditor;
  LIOTASourceEditor: IOTASourceEditor;

  function GetFileEditorForModule(Module: IOTAModule; Index: Integer): IOTAEditor;
  begin
    Result := nil;
    if not Assigned(Module) then
      Exit;
    try
      {$IFDEF BCB5}
      if IsCpp(Module.FileName)and(Module.GetModuleFileCount = 2)and(Index = 1)then
        Index := 2;
      {$ENDIF}
      Result := Module.GetModuleFileEditor(Index);
    except
      Result := nil;
    end;
  end;

begin
  if(not Assigned(AIOTAModule))then
  begin
    Result := nil;
    Exit;
  end;

  for i := 0 to Pred(AIOTAModule.GetModuleFileCount) do
  begin
    LIOTAEditor := GetFileEditorForModule(AIOTAModule, i);
    if(Supports(LIOTAEditor, IOTASourceEditor, LIOTASourceEditor))then
    begin
      if(Assigned(LIOTASourceEditor))then
      begin
        if(AFileName = '')or(SameFileName(LIOTASourceEditor.FileName, AFileName))then
        begin
          Result := LIOTASourceEditor;
          Exit;
        end;
      end;
    end;
  end;
  Result := nil;
end;

class function TDelphiCopilotUtilsOTA.GetIOTAEditBufferCurrentModule: IOTAEditBuffer;
var
  LIOTAModule: IOTAModule;
begin
  Result := nil;

  LIOTAModule := Self.GetCurrentModule;
  if(LIOTAModule = nil)then
    Exit;

  Result := TDelphiCopilotUtilsOTA.GetIOTAEditBuffer(LIOTAModule);
end;

class function TDelphiCopilotUtilsOTA.GetIOTAEditBuffer(AIOTAModule: IOTAModule): IOTAEditBuffer;
var
  LIOTASourceEditor: IOTASourceEditor;
begin
  Result := nil;
  LIOTASourceEditor := Self.GetIOTASourceEditor(AIOTAModule);
  if(LIOTASourceEditor = nil)then
    Exit;

  if(not Supports(LIOTASourceEditor, IOTAEditBuffer, Result))then
    raise Exception.Create('Interface not supported: IOTAEditBuffer');
end;

class function TDelphiCopilotUtilsOTA.GetIOTAMessageServices: IOTAMessageServices;
begin
  if(not Supports(BorlandIDEServices, IOTAMessageServices, Result))then
    raise Exception.Create('Interface not supported: IOTAMessageServices');
end;

class function TDelphiCopilotUtilsOTA.GetIOTAProjectManager: IOTAProjectManager;
begin
  if(not Supports(BorlandIDEServices, IOTAProjectManager, Result))then
    raise Exception.Create('Interface not supported: IOTAProjectManager');
end;

class function TDelphiCopilotUtilsOTA.GetIOTAKeyboardServices: IOTAKeyboardServices;
begin
  if(not Supports(BorlandIDEServices, IOTAKeyboardServices, Result))then
    raise Exception.Create('Interface not supported: IOTAKeyboardServices');
end;

class function TDelphiCopilotUtilsOTA.GetIOTAServices: IOTAServices;
begin
  if(not Supports(BorlandIDEServices, IOTAServices, Result))then
    raise Exception.Create('Interface not supported: IOTAServices');
end;

class function TDelphiCopilotUtilsOTA.GetIOTAActionServices: IOTAActionServices;
begin
  if(not Supports(BorlandIDEServices, IOTAActionServices, Result))then
    raise Exception.Create('Interface not supported: IOTAActionServices');
end;

class function TDelphiCopilotUtilsOTA.GetINTAServices: INTAServices;
begin
  if(not Supports(BorlandIDEServices, INTAServices, Result))then
    raise Exception.Create('Interface not supported: INTAServices');
end;

class function TDelphiCopilotUtilsOTA.GetIOTAModuleServices: IOTAModuleServices;
begin
  if(not Supports(BorlandIDEServices, IOTAModuleServices, Result))then
    raise Exception.Create('Interface not supported: IOTAModuleServices');
end;

class function TDelphiCopilotUtilsOTA.GetIOTAEditorServices: IOTAEditorServices;
begin
  if(not Supports(BorlandIDEServices, IOTAEditorServices, Result))then
    raise Exception.Create('Interface not supported: IOTAEditorServices');
end;

class function TDelphiCopilotUtilsOTA.GetCurrentModule: IOTAModule;
var
  LIOTAModuleServices: IOTAModuleServices;
begin
  Result := nil;
  LIOTAModuleServices := Self.GetIOTAModuleServices;
  if(LIOTAModuleServices <> nil)then
    Result := LIOTAModuleServices.CurrentModule;
end;

class function TDelphiCopilotUtilsOTA.GetCurrentModuleFileName: string;
var
  LIOTAModule: IOTAModule;
begin
  Result := '';
  LIOTAModule := Self.GetCurrentModule;
  if(Assigned(LIOTAModule))then
    Result := LIOTAModule.FileName.Trim;
end;

class function TDelphiCopilotUtilsOTA.GetModule(const AFileName: string): IOTAModule;
var
  LIOTAModuleServices: IOTAModuleServices;
begin
  Result := nil;
  LIOTAModuleServices := Self.GetIOTAModuleServices;
  if(LIOTAModuleServices <> nil)then
    Result := LIOTAModuleServices.FindModule(AFileName);
end;

class function TDelphiCopilotUtilsOTA.GetCurrentProjectGroup: IOTAProjectGroup;
begin
  Result := Self.GetIOTAModuleServices.MainProjectGroup;
end;

class function TDelphiCopilotUtilsOTA.GetCurrentProject: IOTAProject;
var
  LIOTAProjectGroup: IOTAProjectGroup;
begin
  Result := nil;
  LIOTAProjectGroup := Self.GetCurrentProjectGroup;
  if(not Assigned(LIOTAProjectGroup))then
    Exit;

  try
    Result := LIOTAProjectGroup.ActiveProject;
  except
    ;
  end;
end;

class function TDelphiCopilotUtilsOTA.GetCurrentProjectFileName: string;
var
  LIOTAProject: IOTAProject;
begin
  Result := '';
  LIOTAProject := Self.GetCurrentProject;
  if(Assigned(LIOTAProject))then
    Result := LIOTAProject.FileName.Trim;
end;

class function TDelphiCopilotUtilsOTA.GetProjectName(const AIOTAProject: IOTAProject): string;
var
  i: Integer;
  LExt: string;
begin
  Result := ExtractFileName(AIOTAProject.FileName);
  for i := 0 to Pred(AIOTAProject.ModuleFileCount) do
  begin
    LExt := LowerCase(ExtractFileExt(AIOTAProject.ModuleFileEditors[i].FileName));
    if(LExt = TC4DExtensionsFiles.DPR.ToString)or(LExt = TC4DExtensionsFiles.DPK.ToString) Then
    begin
      Result := ChangeFileExt(Result, LExt);
      Break;
    end;
  end;
end;

class function TDelphiCopilotUtilsOTA.GetFileNameDprOrDpkIfDproj(const AIOTAModule: IOTAModule): string;
var
  i: Integer;
  LExt: string;
  LFileName: string;
begin
  Result := AIOTAModule.FileName;

  if ExtractFileExt(Result) = TC4DExtensionsFiles.DPROJ.ToStringWithPoint then
  begin
    for i := 0 to Pred(AIOTAModule.ModuleFileCount) do
    begin
      LFileName := AIOTAModule.ModuleFileEditors[i].FileName;
      LExt := ExtractFileExt(LFileName);

      if(LExt = TC4DExtensionsFiles.DPR.ToStringWithPoint)or(LExt = TC4DExtensionsFiles.DPK.ToStringWithPoint)then
        Result := LFileName;
    end;
  end;
end;

class function TDelphiCopilotUtilsOTA.GetCurrentProjectOptions: IOTAProjectOptions;
var
  LIOTAProject: IOTAProject;
begin
  Result := nil;
  LIOTAProject := Self.GetCurrentProject;
  if(LIOTAProject = nil)then
    Exit;

  Result := LIOTAProject.ProjectOptions;
end;

class function TDelphiCopilotUtilsOTA.GetCurrentOutputDir: string;
var
  LIOTAProjectOptions: IOTAProjectOptions;
begin
  LIOTAProjectOptions := Self.GetCurrentProjectOptions;
  if(LIOTAProjectOptions = nil)then
    Exit;

  Result := VarToStr(LIOTAProjectOptions.Values['OutputDir']);
end;

class function TDelphiCopilotUtilsOTA.GetCurrentProjectOptionsConfigurations: IOTAProjectOptionsConfigurations;
var
  LIOTAProjectOptions: IOTAProjectOptions;
begin
  LIOTAProjectOptions := Self.GetCurrentProjectOptions;
  if(LIOTAProjectOptions <> nil)then
    if(Supports(LIOTAProjectOptions, IOTAProjectOptionsConfigurations, Result))then
      Exit;

  Result := nil;
end;


class function TDelphiCopilotUtilsOTA.GetPathsFilesOpened: TList<string>;
var
  LIOTAModuleServices: IOTAModuleServices;
  LFilePath: string;
  i: Integer;
begin
  LIOTAModuleServices := Self.GetIOTAModuleServices;
  Result := TList<string>.Create;
  Result.Add('Opened');
  for i := 0 to Pred(LIOTAModuleServices.GetModuleCount) do
  begin
    LFilePath := LIOTAModuleServices.GetModule(i).FileName;
    Result.Add(LFilePath);
  end;
end;

class procedure TDelphiCopilotUtilsOTA.GetAllFilesFromProjectGroup(AListFiles: TStrings;
  const AFilePathProjectOrGroupForFilter: string;
  const AC4DWizardExtensions: TC4DExtensionsOfFiles);
var
  LIOTAModuleServices: IOTAModuleServices;
  LIOTAModuleCurrent: IOTAModule;
  LOTAProjectGroup: IOTAProjectGroup;
  LIOTAProjectCurrent: IOTAProject;
  LContModule: Integer;
  LContProject: Integer;
  LContFile: Integer;
  LFilePath: string;
  LFilterIsProjectGroup: Boolean;
  LFilterIsProject: Boolean;
begin
  LIOTAModuleServices := Self.GetIOTAModuleServices;
  if(LIOTAModuleServices = nil)then
    Exit;

  if(LIOTAModuleServices.ModuleCount = 0)then
    Exit;

  LFilterIsProjectGroup := False;
  LFilterIsProject := False;
  if(not AFilePathProjectOrGroupForFilter.Trim.IsEmpty)then
  begin
    if(TDelphiCopilotUtils.IsProjectGroup(AFilePathProjectOrGroupForFilter))then
      LFilterIsProjectGroup := True
    else if(TDelphiCopilotUtils.IsProject(AFilePathProjectOrGroupForFilter))
      or(TDelphiCopilotUtils.IsDPROJ(AFilePathProjectOrGroupForFilter))
    then
      LFilterIsProject := True;
  end;

  for LContModule := 0 to Pred(LIOTAModuleServices.ModuleCount) do
  begin
    LIOTAModuleCurrent := LIOTAModuleServices.Modules[LContModule];
    LFilePath := LIOTAModuleCurrent.FileName;
    if(Supports(LIOTAModuleCurrent, IOTAProjectGroup, LOTAProjectGroup))then
    begin
      if(LFilterIsProjectGroup)and(LFilePath <> AFilePathProjectOrGroupForFilter)then
        Continue;

      for LContProject := 0 to Pred(LOTAProjectGroup.ProjectCount) do
      begin
        LIOTAProjectCurrent := LOTAProjectGroup.Projects[LContProject];

        if(LFilterIsProject)and(LIOTAProjectCurrent.FileName <> AFilePathProjectOrGroupForFilter)then
          Continue;

        for LContFile := 0 to Pred(LIOTAProjectCurrent.GetModuleCount) do
        begin
          LFilePath := LIOTAProjectCurrent.GetModule(LContFile).FileName;
          if(LFilePath.Trim.IsEmpty)then
            Continue;

          if(not AC4DWizardExtensions.ContainsStr(ExtractFileExt(LFilePath)))then
            Continue;

          AListFiles.Add(LFilePath);
        end;
      end;
    end;
  end;
end;

end.
