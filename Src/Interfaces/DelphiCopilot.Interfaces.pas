unit DelphiCopilot.Interfaces;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  DelphiCopilot.Types;

type
  IDelphiCopilotUsesOrganizationParams = interface;
  IDelphiCopilotUsesOrganizationListOfUses = interface;

  IDelphiCopilotIDEMainMenu = interface
    ['{AE2F4702-14B1-42A1-A791-CEBCAAF519E1}']
    procedure CreateMenus;
  end;

  IDelphiCopilotOneUseForLine = interface
    ['{BAB5ACC2-7CCC-435B-A237-4730BF0B2944}']
    procedure Process;
  end;

  IDelphiCopilotAbout = interface
    ['{D0120219-6F60-4047-893F-23B8E7D2AFA0}']
    procedure Show;
  end;

  IDelphiCopilotModelFilesLoop = interface
    ['{909B7294-442D-448E-8D35-07D6DFAF29D6}']
    function Extensions(AValue: TC4DExtensionsOfFiles): IDelphiCopilotModelFilesLoop;
    function Escope(AValue: TC4DWizardEscope): IDelphiCopilotModelFilesLoop;
    function DirectoryForSearch(AValue: string): IDelphiCopilotModelFilesLoop;
    function IncludeSubdirectories(AValue: Boolean): IDelphiCopilotModelFilesLoop;
    function Cancel: IDelphiCopilotModelFilesLoop;
    function Canceled: Boolean;
    procedure LoopInFiles(AProc: TProc<TC4DWizardInfoFile>);
  end;

  IDelphiCopilotUsesOrganization = interface
    ['{8C922CAB-2D74-495B-BED8-E02B2FDA8CD1}']
    function Params: IDelphiCopilotUsesOrganizationParams;
    function CountAlterFiles: Integer;
    function GetGroupNameMsg: string;
    procedure UsesOrganizationInFile(AInfoFile: TC4DWizardInfoFile);
    function ResetValues: IDelphiCopilotUsesOrganization;
  end;

  IDelphiCopilotUsesOrganizationParams = interface
    ['{5B90284A-8212-427C-AF71-F29289BDB9B5}']
    function OrderUsesInAlphabeticalOrder: Boolean; overload;
    function OrderUsesInAlphabeticalOrder(Value: Boolean): IDelphiCopilotUsesOrganizationParams; overload;
    function OneUsesPerLine: Boolean; overload;
    function OneUsesPerLine(Value: Boolean): IDelphiCopilotUsesOrganizationParams; overload;
    function OneUsesLineNumColBefore: Integer; overload;
    function OneUsesLineNumColBefore(Value: Integer): IDelphiCopilotUsesOrganizationParams; overload;
    function MaxCharactersPerLine: Integer; overload;
    function MaxCharactersPerLine(Value: Integer): IDelphiCopilotUsesOrganizationParams; overload;
    function GroupUnitsByNamespaces: Boolean; overload;
    function GroupUnitsByNamespaces(Value: Boolean): IDelphiCopilotUsesOrganizationParams; overload;
    function LineBreakBetweenNamespaces: Boolean; overload;
    function LineBreakBetweenNamespaces(Value: Boolean): IDelphiCopilotUsesOrganizationParams; overload;
    function UsesToRemoveList: IDelphiCopilotUsesOrganizationListOfUses;
    function UsesToAddList: IDelphiCopilotUsesOrganizationListOfUses;
    function ShowMessages: Boolean; overload;
    function ShowMessages(Value: Boolean): IDelphiCopilotUsesOrganizationParams; overload;
    function End_: IDelphiCopilotUsesOrganization;
  end;

  IDelphiCopilotUsesOrganizationList = interface
    ['{F311BFA0-D396-4601-A045-3717DD09879B}']
    function StringListUnit(const Value: TStringList): IDelphiCopilotUsesOrganizationList;
    function Kind(const Value: TC4DWizardListUsesKind): IDelphiCopilotUsesOrganizationList;
    function Prefix(const Value: string): IDelphiCopilotUsesOrganizationList;
    function Suffix(const Value: string): IDelphiCopilotUsesOrganizationList;
    function ImplementationIni(const AImplementationIni: Boolean): IDelphiCopilotUsesOrganizationList;
    function ListUsesInterface(const Value: TStringList): IDelphiCopilotUsesOrganizationList;
    function Text(const Value: string): IDelphiCopilotUsesOrganizationList; overload;
    function Text: string; overload;
    function GetTextListUses: string;
  end;

  IDelphiCopilotUsesOrganizationListOfUses = interface
    ['{DC5B9D38-DF5E-44D3-82EF-03F00898B417}']
    function Enabled: Boolean; overload;
    function Enabled(const Value: Boolean): IDelphiCopilotUsesOrganizationListOfUses; overload;
    function List: TStringList;
    function UsesStr(const Value: string): IDelphiCopilotUsesOrganizationListOfUses;
    function StringsFiltersStr(const Value: string): IDelphiCopilotUsesOrganizationListOfUses;
    function StringsFiltersList: TStringList;
    function ContainsValue(const Value: string): Boolean;
    function End_: IDelphiCopilotUsesOrganizationParams;
  end;

  IDelphiCopilotModelIniFile = interface
    ['{B4426AA0-2D30-4E52-BA21-3BDAC60EB0F9}']
    function Write(const AComponent: TCheckBox): IDelphiCopilotModelIniFile; overload;
    function Write(const AComponent: TRadioGroup): IDelphiCopilotModelIniFile; overload;
    function Write(const AComponent: TEdit): IDelphiCopilotModelIniFile; overload;
    function Write(const AComponent: TComboBox; const AMaxItemsSave: Integer = 40): IDelphiCopilotModelIniFile; overload;
    function Read(var AComponent: TCheckBox; AValueDefault: Boolean): IDelphiCopilotModelIniFile; overload;
    function Read(var AComponent: TRadioGroup; AValueDefault: Integer): IDelphiCopilotModelIniFile; overload;
    function Read(var AComponent: TEdit; AValueDefault: string): IDelphiCopilotModelIniFile; overload;
    function Read(var AComponent: TComboBox; AValueDefault: string): IDelphiCopilotModelIniFile; overload;
  end;

  IDelphiCopilotSettingsModel = interface
    ['{0D5EE063-B22C-4578-90C0-5A3B731D0644}']
    function ShortcutUsesOrganizationUse: Boolean; overload;
    function ShortcutUsesOrganizationUse(Value: Boolean): IDelphiCopilotSettingsModel; overload;
    function ShortcutUsesOrganization: string; overload;
    function ShortcutUsesOrganization(Value: string): IDelphiCopilotSettingsModel; overload;

    function ShortcutReopenFileHistoryUse: Boolean; overload;
    function ShortcutReopenFileHistoryUse(Value: Boolean): IDelphiCopilotSettingsModel; overload;
    function ShortcutReopenFileHistory: string; overload;
    function ShortcutReopenFileHistory(Value: string): IDelphiCopilotSettingsModel; overload;

    function ShortcutTranslateTextUse: Boolean; overload;
    function ShortcutTranslateTextUse(Value: Boolean): IDelphiCopilotSettingsModel; overload;
    function ShortcutTranslateText: string; overload;
    function ShortcutTranslateText(Value: string): IDelphiCopilotSettingsModel; overload;

    function ShortcutIndentUse: Boolean; overload;
    function ShortcutIndentUse(Value: Boolean): IDelphiCopilotSettingsModel; overload;
    function ShortcutIndent: string; overload;
    function ShortcutIndent(Value: string): IDelphiCopilotSettingsModel; overload;

    function ShortcutFindInFilesUse: Boolean; overload;
    function ShortcutFindInFilesUse(Value: Boolean): IDelphiCopilotSettingsModel; overload;
    function ShortcutFindInFiles: string; overload;
    function ShortcutFindInFiles(Value: string): IDelphiCopilotSettingsModel; overload;

    function ShortcutReplaceFilesUse: Boolean; overload;
    function ShortcutReplaceFilesUse(Value: Boolean): IDelphiCopilotSettingsModel; overload;
    function ShortcutReplaceFiles: string; overload;
    function ShortcutReplaceFiles(Value: string): IDelphiCopilotSettingsModel; overload;

    function ShortcutNotesUse: Boolean; overload;
    function ShortcutNotesUse(Value: Boolean): IDelphiCopilotSettingsModel; overload;
    function ShortcutNotes: string; overload;
    function ShortcutNotes(Value: string): IDelphiCopilotSettingsModel; overload;

    function ShortcutVsCodeIntegrationOpenUse: Boolean; overload;
    function ShortcutVsCodeIntegrationOpenUse(Value: Boolean): IDelphiCopilotSettingsModel; overload;
    function ShortcutVsCodeIntegrationOpen: string; overload;
    function ShortcutVsCodeIntegrationOpen(Value: string): IDelphiCopilotSettingsModel; overload;

    function ShortcutGitHubDesktopUse: Boolean; overload;
    function ShortcutGitHubDesktopUse(Value: Boolean): IDelphiCopilotSettingsModel; overload;
    function ShortcutGitHubDesktop: string; overload;
    function ShortcutGitHubDesktop(Value: string): IDelphiCopilotSettingsModel; overload;

    function ShortcutDefaultFilesInOpeningProjectUse: Boolean; overload;
    function ShortcutDefaultFilesInOpeningProjectUse(Value: Boolean): IDelphiCopilotSettingsModel; overload;
    function ShortcutDefaultFilesInOpeningProject: string; overload;
    function ShortcutDefaultFilesInOpeningProject(Value: string): IDelphiCopilotSettingsModel; overload;

    function BlockKeyInsert: Boolean; overload;
    function BlockKeyInsert(Value: Boolean): IDelphiCopilotSettingsModel; overload;

    function BeforeCompilingCheckRunning: Boolean; overload;
    function BeforeCompilingCheckRunning(Value: Boolean): IDelphiCopilotSettingsModel; overload;

    function WriteIniFile: IDelphiCopilotSettingsModel;
    function ReadIniFile: IDelphiCopilotSettingsModel;
  end;

  IDelphiCopilotIndent = interface
    ['{15D5EFAE-958A-450F-8E20-BBB0D82DE64A}']
    procedure ProcessBlockSelected;
  end;

implementation

end.
