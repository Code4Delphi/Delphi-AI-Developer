unit DelphiAIDev.IDE.OTAEditorNotifier;

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
  DelphiAIDev.CodeCompletion.Vars,
  DelphiAIDev.IDE.NTAEditViewNotifier;

type
  TDelphiAIDevIDEOTAEditorNotifier = class(TNotifierObject, IOTANotifier, IOTAEditorNotifier)
  private
    FIOTASourceEditor: IOTASourceEditor;
    FINTAEditViewNotifierList: TList<INTAEditViewNotifier>;
    FIndex: Integer;
    procedure RemoveNotifiers;
  public
    constructor Create(ASourceEditor: IOTASourceEditor);
    destructor Destroy; override;
    { IOTANotifier }
    procedure Destroyed;
    { IOTAEditorNotifier }
    procedure ViewNotification(const View: IOTAEditView; Operation: TOperation);
    procedure ViewActivated(const View: IOTAEditView);
  end;


implementation

constructor TDelphiAIDevIDEOTAEditorNotifier.Create(ASourceEditor: IOTASourceEditor);
var
  i: Integer;
begin
  inherited Create;
  FINTAEditViewNotifierList := TList<INTAEditViewNotifier>.Create;
  FIOTASourceEditor := ASourceEditor;

  FIndex := FIOTASourceEditor.AddNotifier(Self);
  for i := 0 to Pred(FIOTASourceEditor.EditViewCount) do
    FINTAEditViewNotifierList.Add(TDelphiAIDevIDENTAEditViewNotifier.Create(FIOTASourceEditor.FileName, FIOTASourceEditor.EditViews[i]));
end;

destructor TDelphiAIDevIDEOTAEditorNotifier.Destroy;
begin
  RemoveNotifiers;
  FINTAEditViewNotifierList.Free;
  inherited;
end;

procedure TDelphiAIDevIDEOTAEditorNotifier.Destroyed;
begin
  RemoveNotifiers;
end;

procedure TDelphiAIDevIDEOTAEditorNotifier.RemoveNotifiers;
var
  i: Integer;
begin
  for i := 0 to Pred(FINTAEditViewNotifierList.Count) do
    FINTAEditViewNotifierList[i].Destroyed;
  FINTAEditViewNotifierList.Clear;

  if Assigned(FIOTASourceEditor) and (FIndex >= 0) then
  begin
    FIOTASourceEditor.RemoveNotifier(FIndex);
    FIndex := -1;
    FIOTASourceEditor := nil;
  end;
end;

procedure TDelphiAIDevIDEOTAEditorNotifier.ViewActivated(const View: IOTAEditView);
begin

end;

procedure TDelphiAIDevIDEOTAEditorNotifier.ViewNotification(const View: IOTAEditView; Operation: TOperation);
begin
  if Operation = opInsert then
    FINTAEditViewNotifierList.Add(TDelphiAIDevIDENTAEditViewNotifier.Create(FIOTASourceEditor.FileName, View));
end;

end.
