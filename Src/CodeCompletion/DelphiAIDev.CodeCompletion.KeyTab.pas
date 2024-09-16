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
  i: Integer;
  LTextLine: string;
begin
  try
    if FVars.Contents.Count > 1 then
      AContext.EditBuffer.EditPosition.Delete(Pred(FVars.Contents.Count));

    for i := 0 to Pred(FVars.Contents.Count) do
    begin
      LTextLine := FVars.Contents[i].Trim;

      if FVars.Contents.Count > 1 then
      begin
        AContext.EditBuffer.EditPosition.MoveEOL;
        LTextLine := FVars.Contents[i];
      end;

      AContext.EditBuffer.EditPosition.InsertText(LTextLine + sLineBreak);
    end;
  finally
    FVars.Clear;
  end;
end;

end.
