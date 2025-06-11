unit DelphiAIDev.Consts;

interface

type
  TConsts = class
  public const
    SEMANTIC_VERSION = '2.5.0';
    SEMANTIC_VERSION_LB = 'Version: ' + SEMANTIC_VERSION;
    WIN_CONTROL_FOCU_NIL = nil;
    DELPHI_AI_DEVELOPER_DPROJ = 'DelphiAIDeveloper.dproj';
    DELPHI_AI_DEVELOPER_BPL = 'DelphiAIDeveloper.bpl';
    C4D_PROJECT_GROUP1 = 'ProjectGroup1.groupproj';
    NAME_FOLDER_TEMP = 'Temp';
    NAME_FOLDER_MetaInfo = 'MetaInfo';
    GITHUB_Code4Delphi = 'https://github.com/Code4Delphi';
    GITHUB_PROJECT = 'https://github.com/Code4Delphi/Delphi-AI-Developer';
    APPLICATION_JSON = 'application/json';
    SHORTCUT_CHAT_DEFAULT = 'Ctrl+Shift+Alt+A';
    CODE_COMPLETION_SUGGESTION_COLOR = $777777;
    CODE_COMPLETION_SHORTCUT_INVOKE = 'Alt+Enter';

    MARK_BEGIN_DELPHI = '```delphi';
    MARK_BEGIN_PASCAL = '```objectpascal';
    MARK_BEGIN_PASCAL2 = '``pascal';
    MARK_BEGIN_SQL = '```sql';
    MARK_BEGIN_SQL2 = '``sql';
    MARK_END = '```';
    PREFIX_NAME_SEPARATOR = 'DelphiAIDevSeparator';
    TAG_CODE_COMPLETION = '//Suggestion_Code_Delphi';

    //SETTINGS
    KEY_SETTINGS_IN_WINDOWS_REGISTRY = '\SOFTWARE\DelphiAIDeveloper';
    BASE_URL_GEMINI_DEFAULT = 'https://generativelanguage.googleapis.com/';
    MODEL_GEMINI_DEFAULT = 'v1/models/gemini-1.5-flash:generateContent';
    BASE_URL_OPEN_AI = 'https://api.openai.com/v1/chat/completions/';
    MODEL_OPEN_AI_DEFAULT = 'gpt-4o-2024-08-06';
    BASE_URL_GROQ = 'https://api.groq.com/openai/v1/chat/completions';
    MODEL_GROQ_DEFAULT = 'llama3-70b-8192'; //'llama3-8b-8192';;

    BASE_URL_Mistral = 'https://api.mistral.ai/v1/chat/completions';
    MODEL_Mistral_DEFAULT = 'mistral-small-latest';

    BASE_URL_OLLAMA = 'http://localhost:11434/api/chat';
    MODEL_OLLAMA_DEFAULT = ''; //'tinyllama' 'mistral';

    //NAMES FILES .INI
    FILE_INI_GENERAL_SETTINGS = 'delphi-ai-developer.ini';

    //NAMES FILES .rtf
    FILE_RTF_CHAT = 'chat.rtf';
    FILE_RTF_CHAT_DB = 'chat_db.rtf';

    //NAMES FILE JSON
    FILE_JSON_DEFAULTS_QUESTIONS = 'delphi_ai_developer_questions.json';
    FILE_JSON_DATABASES = 'delphi_ai_developer_databases.json';
    FILE_JSON_PROJECTS = 'delphi_ai_developer_projects.json';

    //ABOUT AND SPLASH
    ABOUT_TITLE = 'Delphi AI Developer';
    ABOUT_COPY_RIGHT = 'Copyright 2025 Code4Delphi Team.';
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
    ITEM_POPUP_MENU_PROJ_EditInformation_CAPTION = 'Edit Information';

    //MAIN MENU IDE NAME AND CAPTIONS
    MENU_IDE_CHAT_NAME = 'DelphiAIDevChat1';
    MENU_IDE_CHAT_CAPTION = 'Chat';

    MENU_IDE_DEFAULTS_QUESTIONS_NAME = 'DelphiAIDevDefaultsQuestions1';
    MENU_IDE_DEFAULTS_QUESTIONS_CAPTION = 'Defaults questions';

    MENU_IDE_DEFAULTS_DATABASES_ADD_NAME = 'DelphiAIDevDatabasesAdd1';
    MENU_IDE_DEFAULTS_DATABASES_ADD_CAPTION = 'Databases Registers';
    MENU_IDE_DEFAULTS_DATABASES_CHAT_NAME = 'DelphiAIDevDatabasesChat1';
    MENU_IDE_DEFAULTS_DATABASES_CHAT_CAPTION = 'Databases Chat';

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
