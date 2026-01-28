unit DelphiAIDev.Utils.Context;

interface

uses
  System.SysUtils,
  System.Classes,
  ToolsAPI;

type
  TUtilsContext = class
  public
    class function GetUnitInterfaceCode: string;
  end;

implementation

class function TUtilsContext.GetUnitInterfaceCode: string;
const
  ChunkSize = 1024;
var
  LModule: IOTAModule;
  LEditor: IOTASourceEditor;
  LReader: IOTAEditReader;
  LBuffer: array[0..ChunkSize - 1] of AnsiChar;
  LPartStr: AnsiString;
  LTotalText: AnsiString;
  LPos: Integer;
  LBytesRead: Integer;
  LImplPos: Integer;
  i: Integer;
begin
  Result := '';
  if not Assigned(BorlandIDEServices) then Exit;
  
  LModule := (BorlandIDEServices as IOTAModuleServices).CurrentModule;
  if not Assigned(LModule) then Exit;

  LEditor := nil;
  for i := 0 to LModule.GetModuleFileCount - 1 do
  begin
    if Supports(LModule.GetModuleFileEditor(i), IOTASourceEditor, LEditor) then
      Break;
  end;

  if not Assigned(LEditor) then Exit;

  LReader := LEditor.CreateReader;
  if not Assigned(LReader) then Exit;

  try
    LPos := 0;
    LTotalText := '';
    
    repeat
      LBytesRead := LReader.GetText(LPos, PAnsiChar(@LBuffer), ChunkSize);
      if LBytesRead > 0 then
      begin
        SetString(LPartStr, PAnsiChar(@LBuffer), LBytesRead);
        LTotalText := LTotalText + LPartStr;
        Inc(LPos, LBytesRead);
      end;
    until LBytesRead < ChunkSize;
    
    Result := String(LTotalText);
    
    LImplPos := Pos('implementation', LowerCase(Result));
    if LImplPos > 0 then
      Result := Copy(Result, 1, LImplPos - 1);
  finally
    LReader := nil;
  end;
end;

end.
