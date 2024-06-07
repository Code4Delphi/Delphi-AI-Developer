unit DelphiCopilot.Consts;

interface

uses
  DelphiCopilot.Types;

type
  TC4DConsts = class
  public const
    SEMANTIC_VERSION = '1.18.0';
    SEMANTIC_VERSION_LB = 'Version: ' + SEMANTIC_VERSION;
    NAME_FOLDER_GIT = '.git\';
    WIN_CONTROL_FOCU_NIL = nil;
    C4D_WIZARD_DPROJ = 'DelphiCopilot.dproj';
    C4D_WIZARD_BPL = 'DelphiCopilot.bpl';
    C4D_PROJECT_GROUP1 = 'ProjectGroup1.groupproj';
    NAME_FOLDER_TEMP = 'Temp';
    DEFAULT_HTM = 'default.htm';
    GITHUB_Code4Delphi = 'https://github.com/Code4Delphi';
    GITHUB_Code4D_Wizard = 'https://github.com/Code4Delphi/Code4D-Wizard';

    //BUILD TYPES
    BUILD_DEBUG = 'Debug';
    BUILD_RELEASE = 'Release';

    //TAGS
    TAG_BLOCK_TEXT_SELECT = '<BlockTextSelect/>';
    TAG_FOLDER_GIT = '<FolderGit/>';
    TAG_FILE_PATH_BINARY = '<FilePathBinary/>';

    //NAMES FILES .INI
    FILE_INI_GENERAL_SETTINGS = 'delphi-copilot.ini';
    FILE_INI_REOPEN = 'reopen.ini';
    FILE_INI_DEFAULT_FILES_IN_OPENING_PROJECT = 'default-files-in-opening-project.ini';
    FILE_INI_GROUPS = 'groups.ini';
    FILE_INI_OPEN_EXTERNAL = 'open-external.ini';

    //NAMES FILES .rtf
    FILE_RTF_NOTES = 'notes.rtf';

    //ABOUT AND SPLASH
    ABOUT_TITLE = 'Delphi Copilot';
    ABOUT_COPY_RIGHT = 'Copyright 2024 Code4Delphi Team.';
    ABOUT_DESCRIPTION = 'Wizard/plugin designed to be used in the Delphi IDE.';
    WIZARD_LICENSE = 'MIT license';
    IS_UNREGISTERED = False;

    //NAMES FILES AND IMAGES RESOURCE
    RESOURCE_c4d_logo_24x24 = 'c4d_logo_24x24';
    RESOURCE_c4d_logo_48x48 = 'c4d_logo_48x48';

    //CAPTIONS ITENS MAIN MENU IDE, AND POPUPMENU PROJ
    ITEM_MENU_Code4D_NAME = 'DelphiCopilotC4DItemMenu';
    ITEM_MENU_Code4D_CAPTION = 'Delphi Copilot';
    ITEM_MENU_Mark_Favorite_CAPTION = 'Mark as Favorite';
    ITEM_MENU_Mark_Unfavorite_CAPTION = 'Mark as Unfavorite';
    ITEM_MENU_EditInformations_CAPTION = 'Edit Informations';
    ITEM_MENU_DefaultFilesInOpeningProject_NAME = 'DelphiCopilotefaultFilesInOpeningProject1';
    ITEM_MENU_DefaultFilesInOpeningProject_CAPTION = 'Default Files In Opening Project';
    ITEM_MENU_OpenInGitHubDesktop_NAME = 'C4DWizarOpenInGitHubDesktop1';
    ITEM_MENU_OpenInGitHubDesktop_CAPTION = 'Open in GitHub Desktop';
    ITEM_MENU_ViewInRemoteRepository_NAME = 'C4DWizarViewInRemoteRepository1';
    ITEM_MENU_ViewInRemoteRepository_CAPTION = 'View in Remote Repository';
    ITEM_MENU_ViewInfRemoteRepository_NAME = 'C4DWizarViewInfRemoteRepository1';
    ITEM_MENU_ViewInfRemoteRepository_CAPTION = 'View Information Remote Repository';
    ITEM_MENU_ViewFileInExplorer_NAME = 'C4DWizarViewFileInExplorer1';
    ITEM_MENU_ViewFileInExplorer_CAPTION = 'View File in Explorer';
    ITEM_MENU_ViewExeInExplorer_CAPTION = 'View Binary in Explorer';
    ITEM_MENU_ViewFileProjInExplorer_NAME = 'C4DWizarViewFileProjectInExplorer1';
    ITEM_MENU_ViewFileProjInExplorer_CAPTION = 'View File Project in Explorer';
    ITEM_MENU_ViewCurFileInExplorer_NAME = 'C4DWizarViewCurrentFileInExplorer1';
    ITEM_MENU_ViewCurFileInExplorer_CAPTION = 'View Current File in Explorer';
    ITEM_MENU_ViewCurExeInExplorer_NAME = 'C4DWizarViewCurrentExeInExplorer1';
    ITEM_MENU_ViewCurExeInExplorer_CAPTION = 'View Current Binary in Explorer';

    //MAIN MENU IDE NAME
    MENU_IDE_OpenExternal_NAME = 'C4DWizarOpenExternal1';
    MENU_IDE_OpenExternal_CAPTION = 'Open External Path';
    MENU_IDE_ORGANIZATION_NAME = 'C4DWizarUsesOrganization1';
    MENU_IDE_ORGANIZATION_CAPTION = 'Uses Organization';
    MENU_IDE_REOPEN_NAME = 'C4DWizarReopen1';
    MENU_IDE_REOPEN_CAPTION = 'Reopen File History';
    MENU_IDE_TRANSLATE_NAME = 'C4DWizarTranslateText1';
    MENU_IDE_TRANSLATE_CAPTION = 'Translate Text';
    MENU_IDE_INDENT_NAME = 'C4DWizarIndent1';
    MENU_IDE_INDENT_CAPTION = 'Indent Text Selected';
    MENU_IDE_FIND_NAME = 'C4DWizarFind1';
    MENU_IDE_FIND_CAPTION = 'Find in Files';
    MENU_IDE_REPLACE_NAME = 'C4DWizarReplace1';
    MENU_IDE_REPLACE_CAPTION = 'Replace in Files';
    MENU_IDE_BACKUP_NAME = 'C4DWizarBackupConfig1';
    MENU_IDE_BACKUP_CAPTION = 'Backup/Restore Configs';
    MENU_IDE_IMPORT_NAME = 'C4DWizarBackupImportConfig1';
    MENU_IDE_IMPORT_CAPTION = 'Import Configs';
    MENU_IDE_EXPORT_NAME = 'C4DWizarBackupExportConfig1';
    MENU_IDE_EXPORT_CAPTION = 'Export Configs';
    MENU_IDE_SETTINGS_NAME = 'C4DWizarSettings1';
    MENU_IDE_SETTINGS_CAPTION = 'Settings';
    MENU_IDE_ABOUT_NAME = 'C4DWizarAbout1';
    MENU_IDE_ABOUT_CAPTION = 'About Code4Delphi Wizard';
    MENU_IDE_FormatSource_NAME = 'C4DFormatSource1';
    MENU_IDE_FormatSource_CAPTION = 'Format Source';
    MENU_IDE_NOTES_NAME = 'DelphiCopilotChat1';
    MENU_IDE_NOTES_CAPTION = 'Chat';
    MENU_IDE_VSCODE_INTEGRATION_NAME = 'C4DWizarVsCodeIntegration1';
    MENU_IDE_VSCODE_INTEGRATION_CAPTION = 'Vs Code Integration';
    MENU_IDE_VSCODE_INTEGRATION_OPEN_NAME = 'C4DWizarVsCodeIntegrationOpen1';
    MENU_IDE_VSCODE_INTEGRATION_OPEN_CAPTION = 'Open In VS Code';
    MENU_IDE_VSCODE_INTEGRATION_INSTALL_DELPHILSP_NAME = 'C4DWizarVsCodeIntegrationInstallDelphiLSP1';
    MENU_IDE_VSCODE_INTEGRATION_INSTALL_DELPHILSP_CAPTION = 'Install DelphiLSP extension in VS Code';
    MENU_IDE_VSCODE_INTEGRATION_INSTALL_GithubCopilot_NAME = 'C4DWizarVsCodeIntegrationInstallGithubCopilot1';
    MENU_IDE_VSCODE_INTEGRATION_INSTALL_GithubCopilot_CAPTION = 'Install GitHub Copilot extension in VS Code';
    MENU_IDE_VSCODE_INTEGRATION_INSTALL_Supermaven_NAME = 'C4DWizarVsCodeIntegrationInstallSupermaven1';
    MENU_IDE_VSCODE_INTEGRATION_INSTALL_Supermaven_CAPTION = 'Install GitHub Supermaven extension in VS Code';

    //FILE .INI REOPEN
    REOPEN_INI_Favorite = 'Favorite';
    REOPEN_INI_Nickname = 'Nickname';
    REOPEN_INI_Name = 'Name';
    REOPEN_INI_LastOpen = 'LastOpen';
    REOPEN_INI_LastClose = 'LastClose';
    REOPEN_INI_FilePath = 'FilePath';
    REOPEN_INI_Color = 'Color';
    REOPEN_INI_FolderGit = 'FolderGit';
    REOPEN_INI_GuidGroup = 'GuidGroup';

    //FILE .INI DefaultFilesInOpeningProject
    DEFAULT_FILES_IN_OPENING_PROJECT_INI_ListFilePathDefault = 'ListFilePathDefault';

    //GROUPS FILE .INI
    GROUPS_GUID_ALL = 'ALL';
    GROUPS_GUID_NO_GROUP = 'NO-GROUP';
    GROUPS_INI_Name = 'Name';
    GROUPS_INI_FixedSystem = 'FixedSystem';
    GROUPS_INI_DefaultGroup = 'DefaultGroup';

    //OpenExternal FILE .INI
    OPEN_EXTERNAL_Separator_PARAMETERS = '|p|';
    OPEN_EXTERNAL_INI_Description = 'Description';
    OPEN_EXTERNAL_INI_Path = 'Path';
    OPEN_EXTERNAL_INI_Parameters = 'Parameters';
    OPEN_EXTERNAL_INI_Kind = 'Kind';
    OPEN_EXTERNAL_INI_Visible = 'Visible';
    OPEN_EXTERNAL_INI_VisibleInToolBarUtilities = 'VisibleInToolBarUtilities';
    OPEN_EXTERNAL_INI_Order = 'Order';
    OPEN_EXTERNAL_INI_Shortcut = 'Shortcut';
    OPEN_EXTERNAL_INI_IconHas = 'IconHas';
    OPEN_EXTERNAL_INI_GuidMenuMaster = 'GuidMenuMaster';
    OPEN_EXTERNAL_INI_PREFIX_IMG = 'OPEN_EXTERNAL_IMG_';

    //TOOLBAR BRANCH
    TOOL_BAR_BRANCH_NAME = 'C4DToolBarBranch';
    TOOL_BAR_BRANCH_CAPTION = 'C4D Branch';
    TOOL_BAR_BRANCH_TOOL_BUTTON_NAME = 'C4DToolButtonGetNameCurrentBranch';
    TOOL_BAR_BRANCH_LABEL_NAME = 'C4DToolLabelNameCurrentBranch';
    //TOOLBAR BRANCH INI
    TOOL_BAR_BRANCH_INI_Visible = 'Visible';

    //TOOLBAR BUILD
    TOOL_BAR_BUILD_NAME = 'C4DToolBarBuild';
    TOOL_BAR_BUILD_CAPTION = 'C4D Build';
    TOOL_BAR_BUILD_TOOL_BUTTON_BuildAllGroup_NAME = 'C4DToolButtonBuildAllGroup';
    TOOL_BAR_BUILD_TOOL_BUTTON_BuildAllGroup_CAPTION = 'Build all group projects';
    TOOL_BAR_BUILD_TOOL_BUTTON_CleanAndBuild_NAME = 'C4DToolButtonCleanAndBuild';
    TOOL_BAR_BUILD_TOOL_BUTTON_CleanAndBuild_CAPTION = 'Clean and build current project';
    TOOL_BAR_BUILD_TOOL_BUTTON_BuildInRelease_NAME = 'C4DToolButtonBuildInRelease';
    TOOL_BAR_BUILD_TOOL_BUTTON_BuildInRelease_CAPTION = 'Build Project In Release';
    TOOL_BAR_BUILD_COMBOBOX_NAME = 'C4DToolComboBoxNameCurrentBuild';
    TOOL_BAR_BUILD_COMBOBOX_HINT = 'Alter Build Configuration';
    TOOL_BAR_BUILD_TOOL_BUTTON_REFRESH_NAME = 'C4DToolButtonBuildRefresh';
    TOOL_BAR_BUILD_TOOL_BUTTON_REFRESH_CAPTION = 'Get Current Build Configuration';
    //TOOLBAR BUILD INI
    TOOL_BAR_BUILD_INI_Visible = 'Visible';

    //TOOLBAR UTILITIES
    TOOL_BAR_UTILITIES_NAME = 'C4DToolBarUtilities';
    TOOL_BAR_UTILITIES_CAPTION = 'C4D Utilities';
    TOOL_BAR_UTILITIES_TOOL_BUTTON_UnitInReadOnly_NAME = 'C4DToolButtoUtilitiesUnitInReadOnly';
    TOOL_BAR_UTILITIES_TOOL_BUTTON_GithubDesktop_NAME = 'C4DToolButtonUtilitiesGithubDesktop';
    //TOOLBAR UTILITIES INI
    TOOL_BAR_UTILITIES_INI_Visible = 'Visible';

    //TOOLBAR VS Code Integration
    TOOL_BAR_VsCodeIntegration_NAME = 'C4DToolBarVsCodeIntegration';
    TOOL_BAR_VsCodeIntegration_CAPTION = 'C4D VS Code Integration';
    TOOL_BAR_VsCodeIntegration_TOOL_BUTTON_OpenInVsCode_NAME = 'C4DToolButtoVsCodeIntegrationOpen';
    TOOL_BAR_VsCodeIntegration_TOOL_BUTTON_OpenInVsCode_CAPTION = 'Open In VS Code';
    //TOOLBAR VS Code Integration INI
    TOOL_BAR_VsCodeIntegration_INI_Visible = 'Visible';

    EXTENSIONS_PERMITTED_BACKUP_EXPORT: TC4DExtensionsOfFiles = [TC4DExtensionsFiles.INI,
      TC4DExtensionsFiles.BMP];

    STR_CMD_COMMANDS = 'CMD Commands';
    STR_MENU_MASTER_ONLY = 'Menu Master Only';

    //ProjectCommands
    COMMAND_ProjectCleanCommand = 'ProjectCleanCommand';
  end;

implementation

end.
