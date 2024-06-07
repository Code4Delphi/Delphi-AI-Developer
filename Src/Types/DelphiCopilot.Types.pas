unit DelphiCopilot.Types;

interface

uses
  System.SysUtils,
  System.Classes,
  System.TypInfo;

type
  TC4DWizardMenuContextList = procedure(const MenuContextList: IInterfaceList) of object;
  TProcReplaceLine = reference to procedure(const ANumLine: Integer; const AStrLineOld, AStrLineNew: string);

  {$SCOPEDENUMS ON}
  TC4DWizardEscope = (FileCurrent = 0, FilesInGroup = 1, FilesInProject = 2, FilesOpened = 3, FilesInDirectories = 4);
  TC4DExtensionsFiles = (None, PAS, DFM, FMX, DPR, DPK, DPROJ, ZIP, BMP, INI, ALL);
  TC4DExtensionsOfFiles = set of TC4DExtensionsFiles;
  TC4DWizardListUsesKind = (Normal, Directiva);
  TC4DWizardFavorite = (None, Yes, No);
  TC4DWizardFileNotification = (None, FileOpened, FileClosing);
  TC4DWizardOpenExternalKind = (None, Files, Folders, Links, Separators, CMD, MenuMasterOnly);
  TC4DWizardIcon = (Information, Question, Warning, Error, Success);
  TC4DButtons = (OK, OK_Cancel);
  TC4DBtnFocu = (OK, Cancel);
  TC4DMsgClear = (ALL, Compiler, Search, Tool);
  TC4DMsgsClear = set of TC4DMsgClear;
  TC4DTextIgnoreEscope = (None = 0, Line = 1, Word = 2);
  {$SCOPEDENUMS OFF}

  TC4DWizardInfoFile = record
    Path: string;
    LastAccess: TDateTime;
  end;

  TC4DWizardReopenData = record
    Favorite: Boolean;
    Nickname: string;
    Name: string;
    LastOpen: TDateTime;
    LastClose: TDateTime;
    FilePath: string;
    Color: string;
    FolderGit: string;
    GuidGroup: string;
    procedure Clear;
  end;

  TC4DWizardOpenExternalKindHelper = record helper for TC4DWizardOpenExternalKind
    function ToString: string;
  end;

  TC4DExtensionsFilesHelper = record helper for TC4DExtensionsFiles
    function ToString: string;
    function ToStringWithPoint: string;
  end;

  TC4DExtensionsOfFilesHelper = record helper for TC4DExtensionsOfFiles
    function ContainsStr(const AExtension: string): Boolean;
  end;

implementation

uses
  DelphiCopilot.Consts;

{ TC4DWizardReopenData }
procedure TC4DWizardReopenData.Clear;
begin
  Self.Favorite := False;
  Self.Nickname := '';
  Self.Name := '';
  Self.LastOpen := 0;
  Self.LastClose := 0;
  Self.FilePath := '';
  Self.Color := 'clBlack';
  Self.FolderGit := '';
  Self.GuidGroup := '';
end;

{TC4DWizardOpenExternalKindHelper}
function TC4DWizardOpenExternalKindHelper.ToString: string;
begin
  if(Self = TC4DWizardOpenExternalKind.CMD)then
    Exit(TC4DConsts.STR_CMD_COMMANDS)
  else if(Self = TC4DWizardOpenExternalKind.MenuMasterOnly)then
    Exit(TC4DConsts.STR_MENU_MASTER_ONLY);

  Result := GetEnumName(TypeInfo(TC4DWizardOpenExternalKind), Integer(Self));
end;

{ TC4DExtensionsFilesHelper }
function TC4DExtensionsFilesHelper.ToString: string;
begin
  Result := GetEnumName(TypeInfo(TC4DExtensionsFiles), Integer(Self)).ToLower;
end;

function TC4DExtensionsFilesHelper.ToStringWithPoint: string;
begin
  Result := '.' + Self.ToString;
end;

{ TC4DExtensionsOfFilesHelper }
function TC4DExtensionsOfFilesHelper.ContainsStr(const AExtension: string): Boolean;
var
  LExtension: string;
begin
  Result := False;
  LExtension := AExtension.Trim.ToLower;
  if(LExtension = '.pas')then
    Result := TC4DExtensionsFiles.PAS in Self
  else if(LExtension = '.dfm')then
    Result := TC4DExtensionsFiles.DFM in Self
  else if(LExtension = '.fmx')then
    Result := TC4DExtensionsFiles.FMX in Self
  else if(LExtension = '.dpr')then
    Result := TC4DExtensionsFiles.DPR in Self
  else if(LExtension = '.dpk')then
    Result := TC4DExtensionsFiles.DPK in Self
  else if(LExtension = '.dproj')then
    Result := TC4DExtensionsFiles.DPROJ in Self
  else if(LExtension = '.zip')then
    Result := TC4DExtensionsFiles.ZIP in Self
  else if(LExtension = '.bmp')then
    Result := TC4DExtensionsFiles.BMP in Self
  else if(LExtension = '.ini')then
    Result := TC4DExtensionsFiles.INI in Self;
end;

end.
