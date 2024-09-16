unit DelphiAIDev.CodeCompletion.KeyTab;

interface

uses
  System.SysUtils,
  System.Classes,
  ToolsAPI,
  DelphiAIDev.CodeCompletion.Vars;

type
  IDelphiAIDevCodeCompletionKeyTab = interface
    ['{A032D6DE-E66D-4088-B384-5FEE82F65160}']
    procedure Process(const AContext: IOTAKeyContext);
  end;

  TDelphiAIDevCodeCompletionKeyTab = class(TInterfacedObject, IDelphiAIDevCodeCompletionKeyTab)
  private
    FVars: TDelphiAIDevCodeCompletionVars;
  protected
    procedure Process(const AContext: IOTAKeyContext);
  public
    class function New: IDelphiAIDevCodeCompletionKeyTab;
    constructor Create;
  end;

implementation

class function TDelphiAIDevCodeCompletionKeyTab.New: IDelphiAIDevCodeCompletionKeyTab;
begin
  Result := Self.Create;
end;

constructor TDelphiAIDevCodeCompletionKeyTab.Create;
begin
  FVars := TDelphiAIDevCodeCompletionVars.GetInstance;
end;

procedure TDelphiAIDevCodeCompletionKeyTab.Process(const AContext: IOTAKeyContext);
var
  LText: string;
  i: Integer;
begin
  LText := '';
  for i := 0 to Pred(FVars.Contents.Count) do
    LText := LText + FVars.Contents[i].Trim + sLineBreak;

  if FVars.Contents.Count > 1 then
    AContext.EditBuffer.EditPosition.Delete(Pred(FVars.Contents.Count));

  AContext.EditBuffer.EditPosition.InsertText(LText.Trim);
  //Context.EditBuffer.EditPosition.Move(TDelphiAIDevCodeCompletionVars.GetInstance.LineEnd, 20);

  FVars.GetInstance.Clear;
end;

end.
