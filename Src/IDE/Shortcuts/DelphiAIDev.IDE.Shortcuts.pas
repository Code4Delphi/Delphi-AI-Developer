unit DelphiAIDev.IDE.Shortcuts;

interface

uses
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  Vcl.Menus,
  ToolsAPI,
  DelphiAIDev.Utils.CnWizard,
  DelphiAIDev.Chat.View;

type
  TDelphiAIDevIDEShortcuts = class(TNotifierObject, IOTAKeyboardBinding)
  private
    //procedure KeyProcBlockReturn(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
    procedure KeyProcBlockReturnAndAlt(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
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
  DelphiAIDev.Utils.OTA;

var
  Index: Integer = -1;

procedure RegisterSelf;
begin
  if Index < 0 then
    Index := TUtilsOTA.GetIOTAKeyboardServices.AddKeyboardBinding(TDelphiAIDevIDEShortcuts.New);
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

class function TDelphiAIDevIDEShortcuts.New: IOTAKeyboardBinding;
begin
  Result := Self.Create;
end;

function TDelphiAIDevIDEShortcuts.GetBindingType: TBindingType;
begin
  Result := btPartial;
end;

function TDelphiAIDevIDEShortcuts.GetDisplayName: string;
begin
  Result := Self.ClassName;
end;

function TDelphiAIDevIDEShortcuts.GetName: string;
begin
  Result := Self.ClassName;
end;

procedure TDelphiAIDevIDEShortcuts.BindKeyboard(const BindingServices: IOTAKeyBindingServices);
begin
//  if TUtilsOTA.CurrentProjectIsDelphiAIDeveloperDPROJ then
//    Exit;

  //BindingServices.AddKeyBinding([Shortcut(VK_RETURN, [])], Self.KeyProcBlockReturn, nil);
  BindingServices.AddKeyBinding([Shortcut(VK_RETURN, [ssAlt])], Self.KeyProcBlockReturnAndAlt, nil);
end;

//procedure TDelphiAIDevIDEShortcuts.KeyProcBlockReturn(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
//begin
//  if KeyCode <> Shortcut(VK_RETURN, []) then
//    Exit;
//
//  TUtils.AddLog(GetCurrentLineOrBlock(CnOtaGetTopMostEditView));
//  BindingResult := TKeyBindingResult.krNextProc; //krUnhandled;
//end;

procedure TDelphiAIDevIDEShortcuts.KeyProcBlockReturnAndAlt(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
var
  LTextCurrentLineOrBlock: string;
begin
  if KeyCode <> Shortcut(VK_RETURN, [ssAlt]) then
    Exit;

  //LTextCurrentLineOrBlock := Context.EditBuffer.EditBlock.Text;
  LTextCurrentLineOrBlock := GetCurrentLineOrBlock(CnOtaGetTopMostEditView).Trim;
  if LTextCurrentLineOrBlock.Trim.IsEmpty then
    Exit;

  if copy(LTextCurrentLineOrBlock, 1, 2) = '//' then
    LTextCurrentLineOrBlock := copy(LTextCurrentLineOrBlock, 3, LTextCurrentLineOrBlock.Length);

  DelphiAIDev.Chat.View.DelphiAIDevChatView.QuestionOnShow := LTextCurrentLineOrBlock;
  DelphiAIDev.Chat.View.DelphiAIDevChatViewShowDockableForm;

  BindingResult := TKeyBindingResult.krUnhandled; //krNextProc;
end;

initialization

finalization
  UnRegisterSelf;

end.
