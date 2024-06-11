unit DelphiCopilot.Consts;

interface

type
  TC4DConsts = class
  public const
    SEMANTIC_VERSION = '1.0.0';
    SEMANTIC_VERSION_LB = 'Version: ' + SEMANTIC_VERSION;
    WIN_CONTROL_FOCU_NIL = nil;
    C4D_WIZARD_DPROJ = 'DelphiCopilot.dproj';
    C4D_WIZARD_BPL = 'DelphiCopilot.bpl';
    C4D_PROJECT_GROUP1 = 'ProjectGroup1.groupproj';
    NAME_FOLDER_TEMP = 'Temp';
    GITHUB_Code4Delphi = 'https://github.com/Code4Delphi';
    GITHUB_DELPHI_COPILOT = 'https://github.com/Code4Delphi/Delphi-Copilot';

    MARK_BEGIN_DELPHI = '```delphi';
    MARK_BEGIN_PASCAL = '```objectpascal';
    MARK_END = '```';

    //SETTINGS
    KEY_SETTINGS_IN_WINDOWS_REGISTRY = '\SOFTWARE\DelphiCopilotC4D';
    BASE_URL_GEMINI_DEFAULT = 'https://generativelanguage.googleapis.com/';
    MODEL_GEMINI_DEFAULT = 'v1/models/gemini-1.5-flash:generateContent';
    BASE_URL_OPEN_AI = 'https://api.openai.com/v1/chat/completions/';
    API_AI_TIMEOUT_DEFAULT = 20;

    //NAMES FILES .INI
    FILE_INI_GENERAL_SETTINGS = 'delphi-copilot.ini';

    //NAMES FILES .rtf
    FILE_RTF_CHAT = 'chat.rtf';

    //ABOUT AND SPLASH
    ABOUT_TITLE = 'Delphi Copilot';
    ABOUT_COPY_RIGHT = 'Copyright 2024 Code4Delphi Team.';
    ABOUT_DESCRIPTION = 'Wizard/plugin designed to be used in the Delphi IDE.';
    WIZARD_LICENSE = 'MIT license';
    IS_UNREGISTERED = False;

    //CAPTIONS ITENS MAIN MENU IDE, AND POPUPMENU PROJ
    ITEM_MENU_Code4D_NAME = 'C4DCopilotItemMenu';
    ITEM_MENU_Code4D_CAPTION = 'Copilot';

    //MAIN MENU IDE NAME AND CAPTIONS
    MENU_IDE_CHAT_NAME = 'DelphiCopilotChat1';
    MENU_IDE_CHAT_CAPTION = 'Chat';
    MENU_IDE_CHAT_SETTINGS_NAME = 'DelphiCopilotSettings1';
    MENU_IDE_CHAT_SETTINGS_CAPTION = 'Settings';
    MENU_IDE_SETTINGS_NAME = 'C4DWizarSettings1';
    MENU_IDE_SETTINGS_CAPTION = 'Settings';
    MENU_IDE_ABOUT_NAME = 'C4DCopilotAbout1';
    MENU_IDE_ABOUT_CAPTION = 'About Delphi Copilot';

    //UTIS
    STR_CMD_COMMANDS = 'CMD Commands';
    STR_MENU_MASTER_ONLY = 'Menu Master Only';
  end;

implementation



end.
