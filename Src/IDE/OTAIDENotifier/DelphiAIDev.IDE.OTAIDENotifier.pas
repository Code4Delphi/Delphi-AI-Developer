unit DelphiAIDev.IDE.OTAIDENotifier;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.Types,
  System.SyncObjs,
  System.RegularExpressions,
  Vcl.Dialogs,
  Vcl.Graphics,
  Vcl.Imaging.pngimage,
  ToolsAPI,
  DelphiAIDev.Utils,
  DelphiAIDev.Consts,
  DelphiAIDev.Types,
  DelphiAIDev.CodeCompletion.Vars,
  DelphiAIDev.IDE.OTAEditorNotifier;

type
  TDelphiAIDevIDEOTAIDENotifier = class(TNotifierObject, IOTANotifier, IOTAIDENotifier)
  private
    FEditorNotifiers: TList<IOTAEditorNotifier>;
  protected
    procedure FileNotification(NotifyCode: TOTAFileNotification;const FileName: string; var Cancel: Boolean);
    procedure BeforeCompile(const Project: IOTAProject; var Cancel: Boolean); overload;
    procedure AfterCompile(Succeeded: Boolean); overload;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  procedure RegisterSelf;

implementation

var
  Index: Integer;

procedure RegisterSelf;
begin
  Index := (BorlandIDEServices as IOTAServices).AddNotifier(TDelphiAIDevIDEOTAIDENotifier.Create);
end;

procedure TDelphiAIDevIDEOTAIDENotifier.AfterCompile(Succeeded: Boolean);
begin
  //
end;

procedure TDelphiAIDevIDEOTAIDENotifier.BeforeCompile(const Project: IOTAProject; var Cancel: Boolean);
begin
  Cancel := False;
end;

constructor TDelphiAIDevIDEOTAIDENotifier.Create;
var
  LIOTAModuleServices: IOTAModuleServices;
  i: Integer;
  j: Integer;
  LIOTAModule: IOTAModule;
  LIOTASourceEditor: IOTASourceEditor;
  LExt: string;
begin
  FEditorNotifiers := TList<IOTAEditorNotifier>.Create;
  LIOTAModuleServices := BorlandIDEServices as IOTAModuleServices;
  for i := 0 to Pred(LIOTAModuleServices.ModuleCount) do
  begin
    LIOTAModule := LIOTAModuleServices.Modules[i];

    for j := 0 to Pred(LIOTAModule.ModuleFileCount) do
      if Supports(LIOTAModule.ModuleFileEditors[j], IOTASourceEditor, LIOTASourceEditor) then
      begin
        LExt := ExtractFileExt(LIOTASourceEditor.FileName).ToLower;
        if LExt.Equals(TC4DExtensionsFiles.PAS.ToStringWithPoint) then
          FEditorNotifiers.Add(TDelphiAIDevIDEOTAEditorNotifier.Create(LIOTASourceEditor));
      end;
  end;

  inherited;
end;

destructor TDelphiAIDevIDEOTAIDENotifier.Destroy;
var
  i: Integer;
begin
  for i := 0 to Pred(FEditorNotifiers.Count) do
    FEditorNotifiers[i].Destroyed;
  FEditorNotifiers.Free;
  inherited;
end;

procedure TDelphiAIDevIDEOTAIDENotifier.FileNotification(NotifyCode: TOTAFileNotification; const FileName: string; var Cancel: Boolean);
var
  LIOTAModule: IOTAModule;
  LExtension: string;
  i: Integer;
  LIOTASourceEditor: IOTASourceEditor;
begin
  Cancel := False;

  if NotifyCode = ofnFileOpened then
  begin
    LIOTAModule := (BorlandIDEServices as IOTAModuleServices).FindModule(FileName);

    if not Assigned(LIOTAModule) then
      Exit;

    for i := 0 to Pred(LIOTAModule.ModuleFileCount) do
      if Supports(LIOTAModule.ModuleFileEditors[i], IOTASourceEditor, LIOTASourceEditor) then
      begin
        LExtension := ExtractFileExt(LIOTASourceEditor.FileName).ToLower;
        if LExtension.Equals(TC4DExtensionsFiles.PAS.ToStringWithPoint) then
          FEditorNotifiers.Add(TDelphiAIDevIDEOTAEditorNotifier.Create(LIOTASourceEditor));
      end;
  end;

  if (NotifyCode <> ofnFileOpened) and (NotifyCode <> ofnFileClosing) then
    Exit;

  LExtension := ExtractFileExt(FileName).ToLower;
  if (LExtension <> TC4DExtensionsFiles.DPROJ.ToStringWithPoint)
    and (LExtension <> TC4DExtensionsFiles.GROUPPROJ.ToStringWithPoint)
  then
    Exit;
end;

initialization

finalization
  if Index >= 0 then
    (BorlandIDEServices as IOTAServices).RemoveNotifier(Index);
end.
