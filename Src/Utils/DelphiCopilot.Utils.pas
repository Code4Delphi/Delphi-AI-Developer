unit DelphiCopilot.Utils;

interface

uses
  Winapi.ShlObj,
  System.SysUtils,
  System.TypInfo,
  Winapi.ShellAPI,
  Winapi.Windows,
  Winapi.PsAPI,
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  System.StrUtils,
  DelphiCopilot.Types;

type
  TUtils = class
  private
    class function ShowMsgInternal(const AMsg, ADetails: string; const AIcon: TDelphiCopilotIcon;
      const AButtons: TC4DButtons; const ABtnFocu: TC4DBtnFocu; const AWinControlFocu: TWinControl): Boolean;
  public
    class function IfThenColor(const Conditional: Boolean; const AColorTrue, AColorFalse: TColor): TColor;
    class function GetFormFromComponent(const AWinControl: TWinControl): TForm;
    class procedure CenterPanel(const APanel: TPanel); overload;
    class procedure CenterPanel(const APanel: TPanel; const AWinControl: TWinControl); overload;
    class procedure TogglePasswordChar(const AEdit: TEdit);
    class function ConfReturnAI(const AValue: string): string;
    class function ProcessTextForEditor(const AText: string): string;
    class function CopyReverse(S: string; Index, Count: Integer): string;
    class function FileNameIsC4DWizardDPROJ(const AFileName: string): Boolean;
    class procedure RemoveBlankSpaceInBegin(var AValue: string; const ACount: Integer);
    class function BlankSpaceInBegin(const AValue: string): Integer;
    class procedure WaitingScreenShow(const AMsg: string = '');
    class procedure WaitingScreenHide;
    class function UTF8ToStr(AValue: string): string;
    class procedure ExplodeList(const AText, ASeparator: string; AStrings: TStrings);
    class procedure MemoVerticalCenter(AMemo: TMemo; ANumLines: Integer; AText: string);
    class function StatusBarNumPanelDblClick(AStatusBar: TStatusBar): Integer; static;
    class function StrToOpenExternalKind(Value: string): TDelphiCopilotOpenExternalKind;
    class procedure OpenExternalKindFillItemsTStrings(Astrings: TStrings);
    class procedure ExtensionFillTStringsWithValid(Astrings: TStrings);
    class function BoolToStrC4D(Value: Boolean): string;
    class function StrToBoolC4D(Value: string): Boolean;
    class function RemoveCommentAfterTwoBars(Value: string): string;
    class procedure FindListVewItem(AListView: TListView; AIndexSubItem: Integer; AStrFind: string);
    class procedure ShellExecuteC4D(AFileName: string); overload;
    class procedure ShellExecuteC4D(AFileName: string; AParameters: string); overload;
    class procedure ShellExecuteC4D(AFileName: string; AShowCmd: Integer); overload;
    class procedure ShellExecuteC4D(AFileName: string; AParameters: string; AShowCmd: Integer); overload;
    class procedure OpenLink(ALink: string);
    class function SelectFile(const ADefaultFile: string = ''): string; overload;
    class function SelectFile(const ADefaultExt: TC4DExtensionsFiles): string; overload;
    class function SelectFile(const ADefaultFile: string; const ADefaultExt: TC4DExtensionsFiles): string; overload;
    class function SelectFolder(const ADefaultFolder: string; const ADefaultFolderIfCancel: Boolean = True): string;
    class function StringToColorDef(AValue: string; AColorDefault: TColor = clBlack): TColor;
    class function DateTimeToStrEmpty(AValue: TDateTime): string;
    class function IncInt(var AValue: Integer): Integer;
    class procedure OpenFile(AFilePath: string);
    class procedure OpenFolder(APathFolder: string);
    class procedure OpenFileOrFolder(APath: string);
    class function GetSpecialFolderPath(const ACsidl: Integer): string;
    class function GetDirProgramFiles: string;
    class function DirectoryDelete(AFullPath: string): Boolean;
    class function DirectoryOrFileMove(AFrom, ATo: string): Boolean;
    class function GetPathFolderRoot: string;
    class function GetPathFileIniGeneralSettings: string;
    class function GetPathFileChat: string;
    class function CreateIfNecessaryAndGetPathFolderTemp: string;
    class function GetGuidStr: string;
    class function GuidToFileName(const AGuid: string; const AExtension: string): string;
    class function GetNamespace(AText: string): string;
    class function GetTextBetween(AText, ADelimitador1, ADelimitador2: string; ACaseSensitive: Boolean = False): string;
    class function RemoveSpacesAll(const AText: string): string;
    class function RemoveSpacesExtras(const AText: string): string;
    class function RemoveEnter(AText: string): string;
    class function ChangeEnterDuplicatedByOne(AText: string): string;
    class function RemoveLastComma(AValue: string): string;
    class function RemoveLastChar(AValue: string; AChar: Char): string;
    class function RemoveLastSemicolon(AValue: string): string;
    class function ChangeLastComma(AValue: string; ANewLastChar: Char): string;
    class function RemoveAccents(AValue: string): string;
    class function RemoveAccentsSwapSymbols(AValue: string): string;
    class function SwapSymbols(AValue: string): string;
    class function FileOnlyPath(AFilePath: string): string;
    class function GetNameFileNoExtension(AFilePath: string): string;
    class function GetExtensionNoPoint(AFilePath: string): string;
    class function FileCopy(const ASource, ADestiny: string; const AReplaceIfExist: Boolean = True): Boolean;
    class function ChangeExtensionToPAS(AFilePath: string): string;
    class function ChangeExtensionToDFM(AFilePath: string): string;
    class function ChangeExtensionToExe(AFilePath: string): string;
    class function ChangeExtensionToDPR(AFilePath: string): string;
    class function ChangeExtensionToDPK(AFilePath: string): string;
    class function ChangeExtension(AFilePath: string; ANewExtension: string): string;
    class function IsDPROJ(const AFilePath: string): Boolean;
    class function IsDPR(const AFilePath: string): Boolean;
    class function IsDPK(const AFilePath: string): Boolean;
    class function IsProjectGroup(const AFilePath: string): Boolean;
    class function IsProject(const AFilePath: string): Boolean;
    class function IsBpr(const AFilePath: string): Boolean;
    {$REGION 'MessagesDeclarations'}
    class procedure ShowMsg(const AMsg: string; const ADetails: string = '');
    class procedure ShowMsgSynchronize(const AMsg: string; const ADetails: string = '');
    class procedure ShowV(const AMsg: string; const ADetails: string = '');
    class procedure ShowError(const AMsg: string; const ADetails: string = ''); overload;
    class procedure ShowError(const AMsg: string; const AWinControlFocu: TWinControl); overload;
    class procedure ShowError(const AMsg: string; const ADetails: string; const AWinControlFocu: TWinControl); overload;
    class function ShowQuestion(const APerg: string; const ADetails: string = ''): Boolean;
    class function ShowQuestion2(const APerg: string; const ADetails: string = ''): Boolean;
    class procedure ShowMsgErrorAndAbort(const AMsg: string; const ADetails: string = ''); overload;
    class procedure ShowMsgErrorAndAbort(const AMsg: string; const AWinControlFocu: TWinControl); overload;
    class procedure ShowMsgErrorAndAbort(const AMsg: string; const ADetails: string; const AWinControlFocu: TWinControl); overload;
    class procedure ShowMsgAndAbort(const AMsg: string; const ADetails: string = ''); overload;
    class procedure ShowMsgAndAbort(const AMsg: string; const AWinControlFocu: TWinControl); overload;
    class procedure ShowMsgAndAbort(const AMsg: string; const ADetails: string; const AWinControlFocu: TWinControl); overload;
    class procedure ShowMsgInMemo(AText: string);
    {$ENDREGION}
  end;

implementation

uses
  DelphiCopilot.View.Memo,
  DelphiCopilot.View.Dialog,
  DelphiCopilot.Consts,
  DelphiCopilot.WaitingScreen;

class function TUtils.IfThenColor(const Conditional: Boolean; const AColorTrue, AColorFalse: TColor): TColor;
begin
  Result := AColorFalse;
  if Conditional then
    Result := AColorTrue;
end;

class function TUtils.GetFormFromComponent(const AWinControl: TWinControl): TForm;
var
  LParent: TComponent;
begin
  Result := nil;
  try
    LParent := TWinControl(AWinControl).Parent;
    while(LParent <> nil)and(not(LParent is TForm)) do
      LParent := TWinControl(LParent).Parent;

    if LParent is TForm then
      Result := TForm(LParent);
  except
  end;
end;

class procedure TUtils.CenterPanel(const APanel: TPanel);
var
  LForm: TForm;
  LFormCenterX: Integer;
  LFormCenterY: Integer;
begin
  LForm := Self.GetFormFromComponent(APanel);

  if LForm = nil then
    Exit;

  LFormCenterX := LForm.Width div 2;
  LFormCenterY := LForm.Height div 2;

  APanel.Left := LFormCenterX - (APanel.Width div 2);
  APanel.Top := LFormCenterY - (APanel.Height div 2);
end;

class procedure TUtils.CenterPanel(const APanel: TPanel; const AWinControl: TWinControl);
var
  LCenterX: Integer;
  LCenterY: Integer;
begin
  if AWinControl = nil then
    Exit;

  LCenterX := AWinControl.Width div 2;
  LCenterY := AWinControl.Height div 2;

  APanel.Left := LCenterX - (APanel.Width div 2);
  APanel.Top := LCenterY - (APanel.Height div 2);
end;

class procedure TUtils.TogglePasswordChar(const AEdit: TEdit);
begin
  if AEdit.PasswordChar = '*' then
    AEdit.PasswordChar := #0
  else
    AEdit.PasswordChar := '*';
end;

class function TUtils.ConfReturnAI(const AValue: string): string;
begin
  Result := AValue
    .Replace('```delphi', '', [rfReplaceAll, rfIgnoreCase])
    .Replace('```', '', [rfReplaceAll]);
end;

class function TUtils.ProcessTextForEditor(const AText: string): string;
var
  AdjustRet: Boolean;
  Strings: TStrings;
  I: Integer;
  SpcCount: Integer;
  c: Char;
  s: string;
begin
  AdjustRet := CopyReverse(AText, 1, 2) = #13#10;
  Strings := TStringList.Create;
  try
    Strings.Text := AText;
    //SpcCount := 0;
    for I := 0 to Pred(Strings.Count) do
    begin
      s := Strings[I];
      if Length(s) > 2 then
      begin
        if s[2] = ' ' then
        begin
          c := s[1];
          s[1] := ' ';
          SpcCount := 0;
          while (SpcCount < Length(s)) and (s[SpcCount + 2] = ' ') do
            Inc(SpcCount);
          s[SpcCount + 1] := c;

          Strings[I] := s;
        end
        else
        begin
          Strings[I] := s;
        end;
      end;
    end;
    Result := Strings.Text;
    Delete(Result, Pred(Result.Length), 2);
  finally
    Strings.Free;
  end;

  if AdjustRet then
    Result := Result + #13#10;
end;

class function TUtils.CopyReverse(S: string; Index, Count : Integer): string;
begin
  Result := ReverseString(S);
  Result := Copy(Result, Index, Count);
  Result := ReverseString(Result);
end;

class function TUtils.FileNameIsC4DWizardDPROJ(const AFileName: string): Boolean;
begin
  Result := ExtractFileName(AFileName) = TC4DConsts.C4D_WIZARD_DPROJ;
end;

class procedure TUtils.RemoveBlankSpaceInBegin(var AValue: string; const ACount: Integer);
begin
  if(ACount <= 0)then
    Exit;

  if Trim(copy(AValue, 1, ACount)).IsEmpty then
    delete(AValue, 1, ACount);
end;

class function TUtils.BlankSpaceInBegin(const AValue: string): Integer;
begin
  Result := AValue.Length - AValue.TrimLeft.Length;
end;

class procedure TUtils.WaitingScreenShow(const AMsg: string = '');
begin
  TDelphiCopilotWaitingScreen.GetInstance.Show(AMsg);
end;

class procedure TUtils.WaitingScreenHide;
begin
  TDelphiCopilotWaitingScreen.GetInstance.Close;
end;

class function TUtils.UTF8ToStr(AValue: string): string;
begin
  Result := UTF8Tostring(RawBytestring(AValue));
end;

class procedure TUtils.ExplodeList(const AText, ASeparator: string; AStrings: TStrings);
var
  LItem: string;
  LText: string;
  LLengthText: Integer;
  LLengthSeparator: Integer;
  I: Integer;
begin
  LText := AText;
  LItem := '';
  LLengthText := LText.Length;
  LLengthSeparator := ASeparator.Length;
  I := 1;
  while(I <= LLengthText)do
  begin
    if(Copy(LText, I, LLengthSeparator) = ASeparator)or(I = LLengthText)then
    begin
      if(I = LLengthText)then
        LItem := LItem + StringReplace(LText[I], ASeparator, '', [rfReplaceAll, rfIgnoreCase]);

      AStrings.Add(Trim(LItem));
      LItem := '';
      I := I + (LLengthSeparator - 1);
    end
    else
    begin
      LItem := LItem + LText[I];
    end;
    I := I + 1;
  end;
end;

class procedure TUtils.MemoVerticalCenter(AMemo: TMemo; ANumLines: Integer; AText: string);
var
  I: Integer;
  LLinesCount: Integer;
begin
  AMemo.Lines.Text := AText.Trim;
  LLinesCount := AMemo.Lines.Count;
  AMemo.ScrollBars := System.UITypes.TScrollStyle.ssVertical;
  if(LLinesCount < ANumLines)then
  begin
    AMemo.ScrollBars := System.UITypes.TScrollStyle.ssNone;
    AMemo.Lines.Clear;
    for I := 1 to Trunc((ANumLines - LLinesCount) / 2)do
      AMemo.Lines.Add(' ');
    AMemo.Lines.Add(AText.Trim);
  end;
end;

class function TUtils.StatusBarNumPanelDblClick(AStatusBar: TStatusBar): Integer;
var
  LPointMouse: Tpoint;
  LWidth: Integer;
  LNumPanel: Integer;
begin
  LNumPanel := 0;
  if(not AStatusBar.SimplePanel)and(AStatusBar.Panels.Count > 0)then
  begin
    LPointMouse := AStatusBar.ScreenToClient(Mouse.CursorPos);
    LWidth := 0;
    for LNumPanel := 0 to AStatusBar.Panels.Count - 2 do
    begin
      LWidth := LWidth + AStatusBar.Panels[LNumPanel].Width;
      if(LPointMouse.X <= LWidth)then
        Break;
    end;
  end;
  Result := LNumPanel;
end;

class function TUtils.StrToOpenExternalKind(Value: string): TDelphiCopilotOpenExternalKind;
begin
  Result := TDelphiCopilotOpenExternalKind.None;
  if(Value = 'Files')then
    Result := TDelphiCopilotOpenExternalKind.Files
  else if(Value = 'Folders')then
    Result := TDelphiCopilotOpenExternalKind.Folders
  else if(Value = 'Links')then
    Result := TDelphiCopilotOpenExternalKind.Links
  else if(Value = 'Separators')then
    Result := TDelphiCopilotOpenExternalKind.Separators
  else if(Value = TC4DConsts.STR_CMD_COMMANDS)then
    Result := TDelphiCopilotOpenExternalKind.CMD
  else if(Value = TC4DConsts.STR_MENU_MASTER_ONLY)then
    Result := TDelphiCopilotOpenExternalKind.MenuMasterOnly;
end;

class procedure TUtils.OpenExternalKindFillItemsTStrings(Astrings: TStrings);
var
  LItem: TDelphiCopilotOpenExternalKind;
begin
  if(Astrings = nil)then
    Exit;

  for LItem := Low(TDelphiCopilotOpenExternalKind) to High(TDelphiCopilotOpenExternalKind) do
  begin
    if(LItem = TDelphiCopilotOpenExternalKind.CMD)then
      Astrings.Add(TC4DConsts.STR_CMD_COMMANDS)
    else  if(LItem = TDelphiCopilotOpenExternalKind.MenuMasterOnly)then
      Astrings.Add(TC4DConsts.STR_MENU_MASTER_ONLY)
    else
      Astrings.Add(GetEnumName(TypeInfo(TDelphiCopilotOpenExternalKind), Integer(LItem)));
  end;
end;

class procedure TUtils.ExtensionFillTStringsWithValid(Astrings: TStrings);
begin
  if(Astrings = nil)then
    Exit;

  Astrings.Clear;
  Astrings.Add('Current Unit');
  Astrings.Add('Files in Project Group');
  Astrings.Add('Files in Project');
  Astrings.Add('All Opened Files');
  Astrings.Add('Files in Directories');
end;

class function TUtils.BoolToStrC4D(Value: Boolean): string;
begin
  Result := IfThen(Value, 'True', 'False');
end;

class function TUtils.StrToBoolC4D(Value: string): Boolean;
begin
  Result := Value = 'True';
end;

class function TUtils.RemoveCommentAfterTwoBars(Value: string): string;
begin
  Result := Value;
  if(Result.Contains('//'))then
    Result := Copy(Result, 1, (Pos('//', Result) - 1));
end;

class procedure TUtils.FindListVewItem(AListView: TListView; AIndexSubItem: Integer; AStrFind: string);
var
  I: Integer;
begin
  if(AStrFind.Trim.IsEmpty)then
    Exit;

  for I := 0 to Pred(AListView.Items.Count)do
  begin
    if(AListView.Items[I].SubItems[AIndexSubItem] = AStrFind)then
    begin
      AListView.ItemIndex := I;
      AListView.SetFocus;
      Break;
    end;
  end;
end;

class procedure TUtils.ShellExecuteC4D(AFileName: string);
begin
  Self.ShellExecuteC4D(AFileName, '', SW_SHOWNORMAL);
end;

class procedure TUtils.ShellExecuteC4D(AFileName, AParameters: string);
begin
  Self.ShellExecuteC4D(AFileName, AParameters, SW_SHOWNORMAL);
end;

class procedure TUtils.ShellExecuteC4D(AFileName: string; AShowCmd: Integer);
begin
  Self.ShellExecuteC4D(AFileName, '', AShowCmd);
end;

class procedure TUtils.ShellExecuteC4D(AFileName: string; AParameters: string; AShowCmd: Integer);
begin
  ShellExecute(Application.Handle, nil, PWideChar(AFileName), PWideChar(AParameters), nil, AShowCmd);
end;

class procedure TUtils.OpenLink(ALink: string);
begin
  Self.ShellExecuteC4D(ALink);
end;

class function TUtils.SelectFile(const ADefaultFile: string = ''): string;
begin
  Result := Self.SelectFile(ADefaultFile, TC4DExtensionsFiles.All)
end;

class function TUtils.SelectFile(const ADefaultExt: TC4DExtensionsFiles): string;
begin
  Result := Self.SelectFile(EmptyStr, ADefaultExt)
end;

class function TUtils.SelectFile(const ADefaultFile: string; const ADefaultExt: TC4DExtensionsFiles): string;
var
  LOpenDialog: TOpenDialog;
  LFolder: string;
begin
  LOpenDialog := TOpenDialog.Create(nil);
  try
    LOpenDialog.Title := 'C4D - Select a file';
    if(not ADefaultFile.Trim.IsEmpty)then
    begin
      LFolder := ExtractFilePath(ADefaultFile);
      if(System.SysUtils.DirectoryExists(LFolder))then
        LOpenDialog.InitialDir := LFolder;

      if(System.SysUtils.FileExists(ADefaultFile))then
        LOpenDialog.FileName := ExtractFileName(ADefaultFile);
    end;

    if(ADefaultExt <> TC4DExtensionsFiles.All)then
    begin
      LOpenDialog.DefaultExt := ADefaultExt.ToString;
      LOpenDialog.Filter := Format('Arquivo %s|*.%s', [ADefaultExt.ToString.ToUpper, ADefaultExt.ToString]);
    end;

    if(not LOpenDialog.Execute)then
      Exit(ADefaultFile);
    Result := LOpenDialog.FileName;
  finally
    LOpenDialog.Free;
  end;
end;

//FOR VERSIONS PRIOR TO DELPHI
{$WARN SYMBOL_PLATFORM OFF}
class function TUtils.SelectFolder(const ADefaultFolder: string; const ADefaultFolderIfCancel: Boolean = True): string;
var
  LFileOpenDialog: TFileOpenDialog;
begin
  Result := '';
  LFileOpenDialog := TFileOpenDialog.Create(nil);
  try
    LFileOpenDialog.Title := 'Delphi Copilot -  Select a folder';
    LFileOpenDialog.Options := [fdoPickFolders];

    if(not ADefaultFolder.Trim.IsEmpty)and(System.SysUtils.DirectoryExists(ADefaultFolder))then
      LFileOpenDialog.DefaultFolder := ADefaultFolder;

    if(not LFileOpenDialog.Execute)then
    begin
      if(ADefaultFolderIfCancel)then
        Result := ADefaultFolder;
      Exit;
    end;

    Result := IncludeTrailingPathDelimiter(LFileOpenDialog.FileName).Trim;
  finally
    LFileOpenDialog.Free;
  end;
end;
{$WARN SYMBOL_PLATFORM ON}

class function TUtils.StringToColorDef(AValue: string; AColorDefault: TColor = clBlack): TColor;
begin
  try
    Result := StringToColor(AValue)
  except
    Result := AColorDefault;
  end;
end;

class function TUtils.DateTimeToStrEmpty(AValue: TDateTime): string;
begin
  Result := '';
  if(AValue > 0)then
    Result := DateTimeToStr(AValue);
end;

class function TUtils.DirectoryDelete(AFullPath: string): Boolean;
var
  LSr: TSearchRec;
  LFullName: string;
begin
  if(not System.SysUtils.DirectoryExists(AFullPath))then
    Exit(False);

  try
    Result := True;
    if(FindFirst(AFullPath + '\*.*', faAnyFile, LSr) = 0)then
    begin
      try
        repeat
          LFullName := IncludeTrailingPathDelimiter(AFullPath) + LSr.Name;
          if(LSr.Name <> '.')and(LSr.Name <> '..')then
          begin
            if((LSr.Attr and faDirectory) = 0)then
              Result := System.SysUtils.DeleteFile(LFullName)
            else
              Result := DirectoryDelete(LFullName);
          end;
        until(FindNext(LSr) <> 0) or not Result;
      finally
        System.SysUtils.FindClose(LSr);
      end;
    end;
    Result := Result and System.SysUtils.DirectoryExists(AFullPath) and RemoveDir(AFullPath);
  except
    Result := False;
  end;
end;

class function TUtils.DirectoryOrFileMove(AFrom, ATo: string): Boolean;
begin
  Result := False;
  try
    if(MoveFile(PWideChar(AFrom), PWideChar(ATo)))then
      Result := True;
  except
    on E: Exception do
      Self.ShowError('Directory or file not moved: ' + E.Message);
  end;
end;

class function TUtils.IncInt(var AValue: Integer): Integer;
begin
  AValue := AValue + 1;
  Result := AValue;
end;

class procedure TUtils.OpenFolder(APathFolder: string);
begin
  Self.ShellExecuteC4D(APathFolder);
end;

class procedure TUtils.OpenFile(AFilePath: string);
begin
  Self.ShellExecuteC4D('explorer.exe', '/select, "' + AFilePath+ '"', SW_NORMAL);
end;

class procedure TUtils.OpenFileOrFolder(APath: string);
begin
  if(FileExists(APath))then
    Self.OpenFile(APath)
  else
    Self.OpenFolder(APath);
end;

class function TUtils.GetSpecialFolderPath(const ACsidl: Integer): string;
var
  LFilePath: array [0..MAX_PATH] of Char;
begin
  SHGetFolderPath(0, ACsidl, 0, 0, LFilePath);
  Result := IncludeTrailingPathDelimiter(LFilePath);
end;

class function TUtils.GetDirProgramFiles: string;
begin
  Result := Self.GetSpecialFolderPath(CSIDL_PROGRAM_FILES);
end;

class function TUtils.GetPathFolderRoot: string;
const
  PATH_WIZARD = 'Code4DCopilot';
begin
  //Result := IncludeTrailingPathDelimiter(Self.GetDirProgramFiles + PATH_WIZARD);
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(GetModuleName(HInstance)) + PATH_WIZARD);
  ForceDirectories(Result);
end;

class function TUtils.GetPathFileIniGeneralSettings: string;
begin
  Result := Self.GetPathFolderRoot + TC4DConsts.FILE_INI_GENERAL_SETTINGS;
end;

class function TUtils.GetPathFileChat: string;
begin
  Result := Self.GetPathFolderRoot + TC4DConsts.FILE_RTF_CHAT;
end;

class function TUtils.CreateIfNecessaryAndGetPathFolderTemp: string;
begin
  Result := Self.GetPathFolderRoot + TC4DConsts.NAME_FOLDER_TEMP;
  if(not DirectoryExists(Result))then
    ForceDirectories(Result);
end;

class function TUtils.GetGuidStr: string;
var
  LGUID1: TGUID;
begin
  Result := '';
  CreateGUID(LGUID1);
  Result := GUIDTostring(LGUID1);
end;

class function TUtils.GuidToFileName(const AGuid: string; const AExtension: string): string;
begin
  Result := AGuid.Replace('{', EmptyStr).Replace('}', EmptyStr) + AExtension.ToLower;
end;

class function TUtils.GetNamespace(AText: string): string;
begin
  Result := '';
  if(ContainsStr(AText, '.'))then
    Result := Copy(AText, 1, Pos('.', AText));
end;

class function TUtils.GetTextBetween(AText, ADelimitador1, ADelimitador2: string; ACaseSensitive: Boolean = False): string;
var
  LPosIni: Integer;
  LPosFim: Integer;
  LText: string;
begin
  Result := '';
  LText := AText;
  if(ACaseSensitive)then
    LPosIni := Pos(ADelimitador1, LText)
  else
    LPosIni := Pos(AnsiUpperCase(ADelimitador1), AnsiUpperCase(LText));

  if(LPosIni > 0)then
    LText := Copy(LText, LPosIni, Length(LText));

  if(ACaseSensitive)then
    LPosFim := Pos(ADelimitador2, LText)
  else
    LPosFim := Pos(AnsiUpperCase(ADelimitador2), AnsiUpperCase(LText));

  if(LPosFim > 0)then
    LText := Copy(LText, 1, LPosFim + Length(ADelimitador2) - 1);

  if(LPosIni > 0)or(LPosFim > 0)then
    Result := LText;
end;

class function TUtils.RemoveSpacesAll(const AText: string): string;
begin
  Result := StringReplace(AText.Trim, ' ', '', [rfReplaceAll]);
end;

class function TUtils.RemoveSpacesExtras(const AText: string): string;
var
  LContinue: Boolean;
begin
  Result := AText;
  LContinue := True;
  while(LContinue)do
  begin
    Result := StringReplace(Result, '  ', ' ', [rfReplaceAll]);
    LContinue := ContainsStr(Result, '  ');
  end;

  Result := Result.Trim;
end;

class function TUtils.RemoveEnter(AText: string): string;
begin
  Result := StringReplace(AText, #$D#$A, '', [rfReplaceAll]);
  Result := StringReplace(Result, #13#10, '', [rfReplaceAll]);
end;

class function TUtils.ChangeEnterDuplicatedByOne(AText: string): string;
begin
  Result := StringReplace(AText, #$D#$A#$D#$A, #$D#$A, [rfReplaceAll]);
  Result := StringReplace(Result, #13#10#13#10, #13#10, [rfReplaceAll]);
end;

class function TUtils.RemoveLastComma(AValue: string): string;
begin
  Result := Self.RemoveLastChar(AValue, ',');
end;

class function TUtils.RemoveLastSemicolon(AValue: string): string;
begin
  Result := Self.RemoveLastChar(AValue, ';');
end;

class function TUtils.ChangeLastComma(AValue: string; ANewLastChar: Char): string;
begin
  Result := AValue;
  AValue := AValue.TrimRight;
  if(not AValue.IsEmpty)then
  begin
    if(RightStr(AValue, 1) = ',')then
    begin
      Delete(AValue, AValue.Length, 1);
      Result := AValue + ANewLastChar;
    end;
  end;
end;

class function TUtils.RemoveLastChar(AValue: string; AChar: Char): string;
begin
  Result := AValue;
  AValue := AValue.Trim;
  if(not AValue.IsEmpty)then
  begin
    if(RightStr(AValue, 1) = AChar)then
    begin
      Delete(AValue, AValue.Length, 1);
      Result := AValue;
    end;
  end;
end;

class function TUtils.RemoveAccentsSwapSymbols(AValue: string): string;
begin
  Result := SwapSymbols(RemoveAccents(AValue));
end;

class function TUtils.RemoveAccents(AValue: string): string;
const
  WITH_ACCENTS = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹';
  OUT_ACCENTS = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
var
  I: Integer;
begin
  for I := 1 to Length(AValue) do
    if(Pos(AValue[I], WITH_ACCENTS) <> 0)then
      AValue[I] := OUT_ACCENTS[Pos(AValue[I], WITH_ACCENTS)];

  Result := AValue;
end;

class function TUtils.SwapSymbols(AValue: string): string;
const
  SYMBOLS_OLD = '∫™&ÆΩºﬂµ˛˝›®Ê∆¯£ÿÉ™ø|~^¥`';
  SYMBOLS_NEW = 'oae   BupyY   o 0faw     ';
var
  I: Integer;
begin
  for I := 1 to Length(AValue)do
    if(Pos(AValue[I], SYMBOLS_OLD) <> 0)then
      AValue[I] := SYMBOLS_NEW[Pos(AValue[I], SYMBOLS_OLD)];

  Result := AValue;
end;

class function TUtils.ChangeExtensionToPAS(AFilePath: string): string;
begin
  Result := Self.ChangeExtension(AFilePath, '.' + TC4DExtensionsFiles.PAS.ToString);
end;

class function TUtils.ChangeExtensionToDFM(AFilePath: string): string;
begin
  Result := Self.ChangeExtension(AFilePath, '.' + TC4DExtensionsFiles.DFM.ToString);
end;

class function TUtils.ChangeExtensionToExe(AFilePath: string): string;
begin
  Result := Self.ChangeExtension(AFilePath, '.exe');
end;

class function TUtils.ChangeExtensionToDPR(AFilePath: string): string;
begin
  Result := Self.ChangeExtension(AFilePath, '.' + TC4DExtensionsFiles.DPR.ToString);
end;

class function TUtils.ChangeExtensionToDPK(AFilePath: string): string;
begin
  Result := Self.ChangeExtension(AFilePath, '.' + TC4DExtensionsFiles.DPK.ToString);
end;

class function TUtils.ChangeExtension(AFilePath: string; ANewExtension: string): string;
begin
  Result := FileOnlyPath(AFilePath) + GetNameFileNoExtension(AFilePath) + ANewExtension;
end;

class function TUtils.FileOnlyPath(AFilePath: string): string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFileDir(AFilePath));
end;

class function TUtils.GetNameFileNoExtension(AFilePath: string): string;
begin
  Result := ExtractFileName(AFilePath);
  Result := ChangeFileExt(Result, EmptyStr);
end;

class function TUtils.GetExtensionNoPoint(AFilePath: string): string;
begin
  Result := ExtractFileExt(AFilePath).ToLower;
  Result := StringReplace(Result, '.', '', [rfReplaceAll]);
end;

class function TUtils.FileCopy(const ASource, ADestiny: string; const AReplaceIfExist: Boolean = True): Boolean;
begin
  try
    CopyFile(PWideChar(ASource), PWideChar(ADestiny), not AReplaceIfExist);
    Result := FileExists(ADestiny);
  except
    Result := False;
  end;
end;

class function TUtils.IsDPROJ(const AFilePath: string): Boolean;
var
  LExtension: string;
begin
  LExtension := GetExtensionNoPoint(AFilePath);
  Result := LExtension = TC4DExtensionsFiles.DPROJ.ToString;
end;

class function TUtils.IsDPR(const AFilePath: string): Boolean;
var
  LExtension: string;
begin
  LExtension := GetExtensionNoPoint(AFilePath);
  Result := LExtension = TC4DExtensionsFiles.DPR.ToString;
end;

class function TUtils.IsDPK(const AFilePath: string): Boolean;
var
  LExtension: string;
begin
  LExtension := GetExtensionNoPoint(AFilePath);
  Result := LExtension = TC4DExtensionsFiles.DPK.ToString;
end;

class function TUtils.IsProjectGroup(const AFilePath: string): Boolean;
begin
  Result := ExtractFileExt(AFilePath).ToLower = '.groupproj';
end;

class function TUtils.IsProject(const AFilePath: string): Boolean;
begin
  Result := Self.IsDPR(AFilePath) or Self.IsBpr(AFilePath);
end;

class function TUtils.IsBpr(const AFilePath: string): Boolean;
begin
  Result := ExtractFileExt(AFilePath).ToLower = '.bpr';
end;

{$REGION 'MessagesImplementation'}
class function TUtils.ShowMsgInternal(const AMsg, ADetails: string; const AIcon: TDelphiCopilotIcon;
  const AButtons: TC4DButtons; const ABtnFocu: TC4DBtnFocu; const AWinControlFocu: TWinControl): Boolean;
begin
  Application.CreateForm(TDelphiCopilotViewDialog, DelphiCopilotViewDialog);
  try
    DelphiCopilotViewDialog.Msg := AMsg;
    DelphiCopilotViewDialog.Details := ADetails;
    DelphiCopilotViewDialog.Icon := AIcon;
    DelphiCopilotViewDialog.Buttons := AButtons;
    DelphiCopilotViewDialog.BtnFocu := ABtnFocu;
    Result := DelphiCopilotViewDialog.ShowModal = mrOK;
  finally
    FreeAndNil(DelphiCopilotViewDialog);
  end;

  if Assigned(AWinControlFocu) then
    if AWinControlFocu.CanFocus then
      AWinControlFocu.SetFocus;
end;

class procedure TUtils.ShowMsg(const AMsg: string; const ADetails: string = '');
begin
  Self.ShowMsgInternal(AMsg, ADetails, TDelphiCopilotIcon.Information, TC4DButtons.OK, TC4DBtnFocu.OK, TC4DConsts.WIN_CONTROL_FOCU_NIL);
end;

class procedure TUtils.ShowMsgSynchronize(const AMsg: string; const ADetails: string = '');
begin
  TThread.Synchronize(nil,
    procedure
    begin
      Self.ShowMsg(AMsg, ADetails);
    end);
end;

class procedure TUtils.ShowV(const AMsg: string; const ADetails: string = '');
begin
  Self.ShowMsgInternal(AMsg, ADetails, TDelphiCopilotIcon.Success, TC4DButtons.OK, TC4DBtnFocu.OK, TC4DConsts.WIN_CONTROL_FOCU_NIL);
end;

class procedure TUtils.ShowError(const AMsg: string; const ADetails: string = '');
begin
  Self.ShowError(AMsg, ADetails, TC4DConsts.WIN_CONTROL_FOCU_NIL);
end;

class procedure TUtils.ShowError(const AMsg: string; const AWinControlFocu: TWinControl);
begin
  Self.ShowError(AMsg, '', AWinControlFocu);
end;

class procedure TUtils.ShowError(const AMsg: string; const ADetails: string; const AWinControlFocu: TWinControl);
begin
  Self.ShowMsgInternal(AMsg, ADetails, TDelphiCopilotIcon.Error, TC4DButtons.OK, TC4DBtnFocu.OK, AWinControlFocu);
end;

class function TUtils.ShowQuestion(const APerg: string; const ADetails: string = ''): Boolean;
begin
  Result := Self.ShowMsgInternal(APerg, ADetails, TDelphiCopilotIcon.Question, TC4DButtons.OK_Cancel, TC4DBtnFocu.OK, TC4DConsts.WIN_CONTROL_FOCU_NIL);
end;

class function TUtils.ShowQuestion2(const APerg: string; const ADetails: string = ''): Boolean;
begin
  Result := Self.ShowMsgInternal(APerg, ADetails, TDelphiCopilotIcon.Question, TC4DButtons.OK_Cancel, TC4DBtnFocu.Cancel, TC4DConsts.WIN_CONTROL_FOCU_NIL);
end;

class procedure TUtils.ShowMsgErrorAndAbort(const AMsg: string; const ADetails: string = '');
begin
  Self.ShowMsgErrorAndAbort(AMsg, ADetails, TC4DConsts.WIN_CONTROL_FOCU_NIL);
end;

class procedure TUtils.ShowMsgErrorAndAbort(const AMsg: string; const AWinControlFocu: TWinControl);
begin
  Self.ShowMsgErrorAndAbort(AMsg, '', AWinControlFocu);
end;

class procedure TUtils.ShowMsgErrorAndAbort(const AMsg: string; const ADetails: string; const AWinControlFocu: TWinControl);
begin
  Self.ShowMsgInternal(AMsg, ADetails, TDelphiCopilotIcon.Error, TC4DButtons.OK, TC4DBtnFocu.OK, AWinControlFocu);
  Abort;
end;

class procedure TUtils.ShowMsgAndAbort(const AMsg: string; const ADetails: string = '');
begin
  Self.ShowMsgAndAbort(AMsg, ADetails, TC4DConsts.WIN_CONTROL_FOCU_NIL)
end;

class procedure TUtils.ShowMsgAndAbort(const AMsg: string; const AWinControlFocu: TWinControl);
begin
  Self.ShowMsgAndAbort(AMsg, '', AWinControlFocu)
end;

class procedure TUtils.ShowMsgAndAbort(const AMsg: string; const ADetails: string; const AWinControlFocu: TWinControl);
begin
  Self.ShowMsgInternal(AMsg, ADetails, TDelphiCopilotIcon.Information, TC4DButtons.OK, TC4DBtnFocu.OK, AWinControlFocu);
  Abort;
end;

class procedure TUtils.ShowMsgInMemo(AText: string);
var
  LDelphiCopilotViewMemo: TDelphiCopilotViewMemo;
begin
  LDelphiCopilotViewMemo := TDelphiCopilotViewMemo.Create(Nil);
  try
    LDelphiCopilotViewMemo.mmMensagem.Lines.Clear;
    LDelphiCopilotViewMemo.mmMensagem.Lines.Add(AText);
    LDelphiCopilotViewMemo.ShowModal;
  finally
    LDelphiCopilotViewMemo.Free
  end;
end;
{$ENDREGION}

end.
