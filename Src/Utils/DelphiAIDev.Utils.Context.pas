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
var
  LModule: IOTAModule;
  LEditor: IOTASourceEditor;
  LReader: IOTAEditReader;
  LBuffer: AnsiString;
  LFileSize: Integer;
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
    LFileSize := LReader.GetFileSize;
    if LFileSize > 0 then
    begin
      SetLength(LBuffer, LFileSize);
      LReader.GetText(0, PAnsiChar(LBuffer), LFileSize);
      
      Result := String(LBuffer);
      
      LImplPos := Pos('implementation', LowerCase(Result));
      if LImplPos > 0 then
        Result := Copy(Result, 1, LImplPos - 1);
    end;
  finally
    LReader := nil;
  end;
end;

end.
