unit DelphiAIDev.Consts;

interface

type
  TConsts = class
  public const
    SEMANTIC_VERSION = '1.8.0';
    SEMANTIC_VERSION_LB = 'Version: ' + SEMANTIC_VERSION;
    WIN_CONTROL_FOCU_NIL = nil;
    DELPHI_AI_DEVELOPER_DPROJ = 'DelphiAIDeveloper.dproj';
    DELPHI_AI_DEVELOPER_BPL = 'DelphiAIDeveloper.bpl';
    C4D_PROJECT_GROUP1 = 'ProjectGroup1.groupproj';
    NAME_FOLDER_TEMP = 'Temp';
    GITHUB_Code4Delphi = 'https://github.com/Code4Delphi';
    GITHUB_PROJECT = 'https://github.com/Code4Delphi/Delphi-AI-Developer';

    MARK_BEGIN_DELPHI = '```delphi';
    MARK_BEGIN_PASCAL = '```objectpascal';
    MARK_BEGIN_PASCAL2 = '``pascal';
    MARK_END = '```';
    PREFIX_NAME_SEPARATOR = 'DelphiAIDevSeparator';

    //SETTINGS
    KEY_SETTINGS_IN_WINDOWS_REGISTRY = '\SOFTWARE\DelphiAIDeveloper';
    BASE_URL_GEMINI_DEFAULT = 'https://generativelanguage.googleapis.com/';
    MODEL_GEMINI_DEFAULT = 'v1/models/gemini-1.5-flash:generateContent';
    BASE_URL_OPEN_AI = 'https://api.openai.com/v1/chat/completions/';
    BASE_URL_GROQ = 'https://api.groq.com/openai/v1/chat/completions';

    //NAMES FILES .INI
    FILE_INI_GENERAL_SETTINGS = 'delphi-ai-developer.ini';

    //NAMES FILES .rtf
    FILE_RTF_CHAT = 'chat.rtf';

    //NAMES FILE JSON
    FILE_JSON_DEFAULTS_QUESTIONS = 'delphi_ai_developer_questions.json';
    FILE_JSON_DATABASES = 'delphi_ai_developer_databases.json';

    //ABOUT AND SPLASH
    ABOUT_TITLE = 'Delphi AI Developer';
    ABOUT_COPY_RIGHT = 'Copyright 2024 Code4Delphi Team.';
    ABOUT_DESCRIPTION = 'Plugin designed to be used in the Delphi IDE.';
    PLUGIN_LICENSE = 'MIT license';
    IS_UNREGISTERED = False;

    //NAMES FILES AND IMAGES RESOURCE
    RESOURCE_c4d_logo_24x24 = 'c4d_logo_24x24';

    //CAPTIONS ITENS MAIN MENU IDE, AND POPUPMENU PROJ
    ITEM_MENU_C4DDelphiAIDev_NAME = 'C4DDelphiAIDevItemMenu';
    ITEM_MENU_C4DDelphiAIDev_CAPTION = 'AI Developer';

    //CODE4D-WIZARD INFORMATION
    //ITEM_MENU_Code4D_CAPTION = 'Code4D';

    //CAPTIONS ITENS POPUPMENU PROJ
    ITEM_POPUP_MENU_PROJ_CAPTION = 'AI Developer';
    ITEM_POPUP_MENU_PROJ_ConfigureDB_CAPTION = 'Configure Database';

    //MAIN MENU IDE NAME AND CAPTIONS
    MENU_IDE_CHAT_NAME = 'DelphiAIDevChat1';
    MENU_IDE_CHAT_CAPTION = 'Chat';

    MENU_IDE_DEFAULTS_QUESTIONS_NAME = 'DelphiAIDevDefaultsQuestions1';
    MENU_IDE_DEFAULTS_QUESTIONS_CAPTION = 'Defaults questions';

    MENU_IDE_DEFAULTS_DATABASES_NAME = 'DelphiAIDevDatabases1';
    MENU_IDE_DEFAULTS_DATABASES_CAPTION = 'Databases';

    MENU_IDE_CHAT_SETTINGS_NAME = 'DelphiAIDevSettings1';
    MENU_IDE_CHAT_SETTINGS_CAPTION = 'Settings';
    MENU_IDE_SETTINGS_NAME = 'C4DWizarSettings1';
    MENU_IDE_SETTINGS_CAPTION = 'Settings';
    MENU_IDE_ABOUT_NAME = 'C4DDelphiAIDevAbout1';
    MENU_IDE_ABOUT_CAPTION = 'About Delphi AI Developer';

    //UTILS
    STR_CMD_COMMANDS = 'CMD Commands';
    STR_MENU_MASTER_ONLY = 'Menu Master Only';

    //SEPARATORS
    SEPARATOR_P = '<|p|>';
  end;

implementation

end.
