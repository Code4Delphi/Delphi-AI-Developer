unit DelphiAIDev.IDE.Shortcuts;

interface

uses
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  Vcl.Menus,
  ToolsAPI,
  DelphiAIDev.Utils.CnWizard;

type
  TDelphiAIDevIDEShortcuts = class(TNotifierObject, IOTAKeyboardBinding)
  private
    procedure KeyProcBlockReturn(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
    procedure KeyProcBlockReturnAndAlt(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
  protected
    function GetBindingType: TBindingType;
    function GetDisplayName: string;
    function GetName: string;
    procedure BindKeyboard(const BindingServices: IOTAKeyBindingServices);
  public
    class function New: IOTAKeyboardBinding;
    constructor Create;
    destructor Destroy; override;
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
  if(Index < 0)and(true)then
    Index := TUtilsOTA.GetIOTAKeyboardServices.AddKeyboardBinding(TDelphiAIDevIDEShortcuts.New);
end;

procedure UnRegisterSelf;
begin
  if(Index >= 0)then
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

constructor TDelphiAIDevIDEShortcuts.Create;
begin

end;

destructor TDelphiAIDevIDEShortcuts.Destroy;
begin
  inherited;
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
  Exit;

  BindingServices.AddKeyBinding([Shortcut(VK_RETURN, [])], Self.KeyProcBlockReturn, nil);
  BindingServices.AddKeyBinding([Shortcut(VK_RETURN, [ssAlt])], Self.KeyProcBlockReturnAndAlt, nil);
end;

procedure TDelphiAIDevIDEShortcuts.KeyProcBlockReturn(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  TUtils.ShowMsg(GetCurrentLine(CnOtaGetTopMostEditView));
  BindingResult := krUnhandled;
end;

procedure TDelphiAIDevIDEShortcuts.KeyProcBlockReturnAndAlt(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  TUtils.ShowMsg('Enter and Alt' + GetCurrentLine(CnOtaGetTopMostEditView));
  BindingResult := krUnhandled;
end;
initialization

finalization
  UnRegisterSelf;

//procedure TDelphiAIDevIDEShortcuts.KeyProcBlockReturnAndAlt(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
//var
//  LIOTAProject: IOTAProject;
//begin
//  LIOTAProject := TUtilsOTA.GetCurrentProject;
//  if LIOTAProject = nil then
//  begin
//    BindingResult := krUnhandled;
//    Exit;
//  end;

//  if TUtils.FileNameIsDelphiAIDeveloperDPROJ(LIOTAProject.FileName) then
//  begin
//    BindingResult := krUnhandled;
//    Exit;
//  end;
//
//  TUtils.ShowMsg('Enter and Alt' + GetCurrentLine(CnOtaGetTopMostEditView));

//  if(C4DWizardSettingsModel.BlockKeyInsert)then
//    BindingResult := krHandled
//  else
//    BindingResult := krUnhandled;
//end;

end.
