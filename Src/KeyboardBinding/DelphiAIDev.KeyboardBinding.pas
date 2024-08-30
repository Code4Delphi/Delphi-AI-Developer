unit DelphiAIDev.KeyboardBinding;

interface

uses
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  Vcl.Menus,
  ToolsAPI,
  DelphiAIDev.Consts,
  DelphiAIDev.Utils.CnWizard,
  DelphiAIDev.Chat.View,
  DelphiAIDev.CodeCompletion.Search,
  DelphiAIDev.CodeCompletion.KeyTab,
  DelphiAIDev.Settings;

type
  TDelphiAIDevKeyboardBinding = class(TNotifierObject, IOTAKeyboardBinding)
  private
    procedure KeyAltHome(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
    procedure KeyTab(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
    //procedure KeyProcBlockReturn(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
    procedure CodeCompletionSearch(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
  protected
    function GetBindingType: TBindingType;
    function GetDisplayName: string;
    function GetName: string;
    procedure BindKeyboard(const BindingServices: IOTAKeyBindingServices);
  public
    class function New: IOTAKeyboardBinding;
  end;

procedure RefreshRegister;

implementation

uses
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA,
  DelphiAIDev.CodeCompletion.Vars;

var
  Index: Integer = -1;

procedure RegisterSelf;
begin
  if Index < 0 then
    Index := TUtilsOTA.GetIOTAKeyboardServices.AddKeyboardBinding(TDelphiAIDevKeyboardBinding.New);
end;

procedure UnRegisterSelf;
begin
  if Index >= 0 then
  begin
    TUtilsOTA.GetIOTAKeyboardServices.RemoveKeyboardBinding(Index);
    Index := -1;
  end;
end;

procedure RefreshRegister;
begin
  UnRegisterSelf;
  RegisterSelf;
end;

class function TDelphiAIDevKeyboardBinding.New: IOTAKeyboardBinding;
begin
  Result := Self.Create;
end;

function TDelphiAIDevKeyboardBinding.GetBindingType: TBindingType;
begin
  Result := btPartial;
end;

function TDelphiAIDevKeyboardBinding.GetDisplayName: string;
begin
  Result := Self.ClassName;
end;

function TDelphiAIDevKeyboardBinding.GetName: string;
begin
  Result := Self.ClassName;
end;

procedure TDelphiAIDevKeyboardBinding.BindKeyboard(const BindingServices: IOTAKeyBindingServices);
var
  LShortcut: string;
begin
//  if TUtilsOTA.CurrentProjectIsDelphiAIDeveloperDPROJ then
//    Exit;

  //BindingServices.AddKeyBinding([Shortcut(VK_RETURN, [ssAlt])], Self.KeyProcBlockReturnAndAlt, nil);
  LShortcut := TConsts.CODE_COMPLETION_SHORTCUT_INVOKE;
  if not(Trim(TDelphiAIDevSettings.GetInstance.CodeCompletionShortcutInvoke).IsEmpty) then
    LShortcut := TDelphiAIDevSettings.GetInstance.CodeCompletionShortcutInvoke;

  BindingServices.AddKeyBinding([TextToShortCut(LShortcut)], Self.CodeCompletionSearch, nil);

  BindingServices.AddKeyBinding([Shortcut(VK_TAB, [])], Self.KeyTab, nil);
  BindingServices.AddKeyBinding([Shortcut(VK_HOME, [ssAlt])], Self.KeyAltHome, nil);
end;

procedure TDelphiAIDevKeyboardBinding.CodeCompletionSearch(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  try
    if TDelphiAIDevSettings.GetInstance.CodeCompletionUse then
      TDelphiAIDevCodeCompletionSearch.New.Process(Context);
  finally
    BindingResult := TKeyBindingResult.krUnhandled;
  end;
end;

procedure TDelphiAIDevKeyboardBinding.KeyTab(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
//  if KeyCode <> Shortcut(VK_TAB, []) then
//    Exit;

  BindingResult := TKeyBindingResult.krUnhandled;

  if TDelphiAIDevCodeCompletionVars.GetInstance.LineIni > 0 then
  begin
    TDelphiAIDevCodeCompletionKeyTab.New.Process(Context);
    BindingResult := TKeyBindingResult.krHandled;
  end;
end;

procedure TDelphiAIDevKeyboardBinding.KeyAltHome(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
var
  LTextCurrentLineOrBlock: string;
begin
  if KeyCode <> Shortcut(VK_RETURN, [ssAlt]) then
    Exit;

  LTextCurrentLineOrBlock := GetCurrentLineOrBlock(CnOtaGetTopMostEditView).Trim;
  if LTextCurrentLineOrBlock.Trim.IsEmpty then
    Exit;

  if copy(LTextCurrentLineOrBlock, 1, 2) = '//' then
    LTextCurrentLineOrBlock := copy(LTextCurrentLineOrBlock, 3, LTextCurrentLineOrBlock.Length);

  DelphiAIDev.Chat.View.DelphiAIDevChatView.QuestionOnShow := LTextCurrentLineOrBlock;
  DelphiAIDev.Chat.View.DelphiAIDevChatViewShowDockableForm;

  BindingResult := TKeyBindingResult.krUnhandled;
end;

initialization

finalization
  UnRegisterSelf;

end.
