unit DelphiAIDev.KeyboardBinding;

interface

uses
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  Vcl.Menus,
  ToolsAPI,
  DelphiAIDev.Utils.CnWizard,
  DelphiAIDev.Chat.View,
  DelphiAIDev.CodeCompletion.Search;

type
  TDelphiAIDevKeyboardBinding = class(TNotifierObject, IOTAKeyboardBinding)
  private
    procedure KeyAltHome(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
    procedure KeyTab(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
    //procedure KeyProcBlockReturn(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
    procedure KeyProcBlockReturnAndAlt(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
    procedure AddBlockText;
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
begin
//  if TUtilsOTA.CurrentProjectIsDelphiAIDeveloperDPROJ then
//    Exit;

  BindingServices.AddKeyBinding([Shortcut(VK_HOME, [ssAlt])], Self.KeyAltHome, nil);
  BindingServices.AddKeyBinding([Shortcut(VK_TAB, [])], Self.KeyTab, nil);

  //BindingServices.AddKeyBinding([Shortcut(VK_RETURN, [])], Self.KeyProcBlockReturn, nil);
  BindingServices.AddKeyBinding([Shortcut(VK_RETURN, [ssAlt])], Self.KeyProcBlockReturnAndAlt, nil);
end;

//procedure TDelphiAIDevKeyboardBinding.KeyProcBlockReturn(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
//begin
//  if KeyCode <> Shortcut(VK_RETURN, []) then
//    Exit;
//
//  TUtils.AddLog(GetCurrentLineOrBlock(CnOtaGetTopMostEditView));
//  BindingResult := TKeyBindingResult.krNextProc; //krUnhandled;
//end;

procedure TDelphiAIDevKeyboardBinding.KeyProcBlockReturnAndAlt(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
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

procedure TDelphiAIDevKeyboardBinding.AddBlockText;
begin
  TDelphiAIDevCodeCompletionVars.GetInstance.Contents.Clear;
  TDelphiAIDevCodeCompletionVars.GetInstance.Contents.Add('  TUtils.AddLog(EmptyStr);');
  TDelphiAIDevCodeCompletionVars.GetInstance.Contents.Add('  TUtils.ShowMsg(EmptyStr);');
  TDelphiAIDevCodeCompletionVars.GetInstance.Contents.Add('  TUtils.ShowMsg(LMsg3);');
end;

procedure TDelphiAIDevKeyboardBinding.KeyAltHome(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
var
  LRow: Integer;
  LColumn: Integer;
  i: Integer;
  LText: string;
begin
  if KeyCode <> Shortcut(VK_HOME, [ssAlt]) then
    Exit;

  TDelphiAIDevCodeCompletionSearch.New.Process(Context);

  //Self.AddBlockText;

  LRow := Context.EditBuffer.EditPosition.Row;
  LColumn := Context.EditBuffer.EditPosition.Column;

  TDelphiAIDevCodeCompletionVars.GetInstance.LineIni := LRow; // + 1;
  TDelphiAIDevCodeCompletionVars.GetInstance.LineEnd := TDelphiAIDevCodeCompletionVars.GetInstance.LineIni + (TDelphiAIDevCodeCompletionVars.GetInstance.Contents.Count); // + 1 //TDelphiAIDevCodeCompletionVars.GetInstance.LineIni + 1;

  //Context.EditBuffer.EditPosition.InsertText(sLineBreak + sLineBreak);
  LText := '';
  for i := 0 to Pred(TDelphiAIDevCodeCompletionVars.GetInstance.Contents.Count) do
    LText := LText + sLineBreak;

  Context.EditBuffer.EditPosition.InsertText(LText.TrimRight + sLineBreak);
  Context.EditBuffer.EditPosition.Move(TDelphiAIDevCodeCompletionVars.GetInstance.LineIni, LColumn);

  TDelphiAIDevCodeCompletionVars.GetInstance.Row := TDelphiAIDevCodeCompletionVars.GetInstance.LineIni;
  TDelphiAIDevCodeCompletionVars.GetInstance.Column := LColumn;

  //Context.EditBuffer.EditPosition.MoveBOL;
  //  //LTextCurrentLineOrBlock := Context.EditBuffer.EditBlock.Text;
  //  LTextCurrentLineOrBlock := GetCurrentLineOrBlock(CnOtaGetTopMostEditView);
  //  if LTextCurrentLineOrBlock.Trim.IsEmpty then
  //    Exit;

  BindingResult := TKeyBindingResult.krUnhandled; //krNextProc;


  //**
  //Self.AddBlockText;

  {LRow := Context.EditBuffer.EditPosition.Row;
  LColumn := Context.EditBuffer.EditPosition.Column;

  TDelphiAIDevCodeCompletionVars.GetInstance.LineIni := LRow; // + 1;
  TDelphiAIDevCodeCompletionVars.GetInstance.LineEnd := TDelphiAIDevCodeCompletionVars.GetInstance.LineIni + (TDelphiAIDevCodeCompletionVars.GetInstance.Contents.Count); // + 1 //TDelphiAIDevCodeCompletionVars.GetInstance.LineIni + 1;

  //Context.EditBuffer.EditPosition.InsertText(sLineBreak + sLineBreak);
  LText := '';
  for i := 0 to Pred(TDelphiAIDevCodeCompletionVars.GetInstance.Contents.Count) do
    LText := LText + sLineBreak;

  Context.EditBuffer.EditPosition.InsertText(LText.TrimRight + sLineBreak);
  Context.EditBuffer.EditPosition.Move(TDelphiAIDevCodeCompletionVars.GetInstance.LineIni, LColumn);

  TDelphiAIDevCodeCompletionVars.GetInstance.Row := TDelphiAIDevCodeCompletionVars.GetInstance.LineIni;
  TDelphiAIDevCodeCompletionVars.GetInstance.Column := LColumn;

  //Context.EditBuffer.EditPosition.MoveBOL;
  //  //LTextCurrentLineOrBlock := Context.EditBuffer.EditBlock.Text;
  //  LTextCurrentLineOrBlock := GetCurrentLineOrBlock(CnOtaGetTopMostEditView);
  //  if LTextCurrentLineOrBlock.Trim.IsEmpty then
  //    Exit;

  BindingResult := TKeyBindingResult.krUnhandled; //krNextProc;  }
end;

procedure TDelphiAIDevKeyboardBinding.KeyTab(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
var
  LText: string;
  i: Integer;
begin
  TUtils.AddLog('KeyTab ' + TDelphiAIDevCodeCompletionVars.GetInstance.LineIni.ToString);

  if KeyCode <> Shortcut(VK_TAB, []) then
    Exit;

  if TDelphiAIDevCodeCompletionVars.GetInstance.LineIni > 0 then
  begin
    //Context.EditBuffer.EditPosition.InsertText('Minha linha 01'  + sLineBreak + 'Linha 2');
    LText := '';
    for i := 0 to Pred(TDelphiAIDevCodeCompletionVars.GetInstance.Contents.Count) do
      LText := LText + TDelphiAIDevCodeCompletionVars.GetInstance.Contents[i].Trim + sLineBreak;

    Context.EditBuffer.EditPosition.InsertText(LText.Trim);
    //Context.EditBuffer.EditPosition.Move(TDelphiAIDevCodeCompletionVars.GetInstance.LineEnd, 20);

    TDelphiAIDevCodeCompletionVars.GetInstance.Clear;
  end;

  BindingResult := TKeyBindingResult.krUnhandled; //krNextProc;
  TUtils.AddLog('KeyTab krUnhandled');
end;

initialization

finalization
  UnRegisterSelf;

end.
