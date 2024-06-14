unit DelphiCopilot.Types;

interface

uses
  System.SysUtils,
  System.Classes,
  System.TypInfo;

type
  TDelphiCopilotMenuContextList = procedure(const MenuContextList: IInterfaceList) of object;
  TProcReplaceLine = reference to procedure(const ANumLine: Integer; const AStrLineOld, AStrLineNew: string);

  {$SCOPEDENUMS ON}
  TAIsAvailable = (Gemini, OpenAI);
  TDelphiCopilotEscope = (FileCurrent = 0, FilesInGroup = 1, FilesInProject = 2, FilesOpened = 3, FilesInDirectories = 4);
  TC4DExtensionsFiles = (None, PAS, DFM, FMX, DPR, DPK, DPROJ, ZIP, BMP, INI, ALL);
  TC4DExtensionsOfFiles = set of TC4DExtensionsFiles;
  TDelphiCopilotListUsesKind = (Normal, Directiva);
  TDelphiCopilotFavorite = (None, Yes, No);
  TDelphiCopilotFileNotification = (None, FileOpened, FileClosing);
  TDelphiCopilotOpenExternalKind = (None, Files, Folders, Links, Separators, CMD, MenuMasterOnly);
  TDelphiCopilotIcon = (Information, Question, Warning, Error, Success);
  TC4DButtons = (OK, OK_Cancel);
  TC4DBtnFocu = (OK, Cancel);
  TC4DMsgClear = (ALL, Compiler, Search, Tool);
  TC4DMsgsClear = set of TC4DMsgClear;
  TC4DTextIgnoreEscope = (None = 0, Line = 1, Word = 2);
  {$SCOPEDENUMS OFF}

  TAIsAvailableHelper = record helper for TAIsAvailable
    function ToString: string;
  end;

  TDelphiCopilotOpenExternalKindHelper = record helper for TDelphiCopilotOpenExternalKind
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

{ TAIsAvailableHelper }
function TAIsAvailableHelper.ToString: string;
begin
  case Self of
    TAIsAvailable.Gemini: Result := 'Gemini';
    TAIsAvailable.OpenAI: Result := 'ChatGPT';
  end;
end;

{TDelphiCopilotOpenExternalKindHelper}
function TDelphiCopilotOpenExternalKindHelper.ToString: string;
begin
  if(Self = TDelphiCopilotOpenExternalKind.CMD)then
    Exit(TC4DConsts.STR_CMD_COMMANDS)
  else if(Self = TDelphiCopilotOpenExternalKind.MenuMasterOnly)then
    Exit(TC4DConsts.STR_MENU_MASTER_ONLY);

  Result := GetEnumName(TypeInfo(TDelphiCopilotOpenExternalKind), Integer(Self));
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
