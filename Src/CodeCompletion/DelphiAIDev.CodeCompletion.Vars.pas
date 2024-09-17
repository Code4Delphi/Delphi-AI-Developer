unit DelphiAIDev.CodeCompletion.Vars;

interface

uses
  System.SysUtils,
  System.Classes,
  ToolsAPI;

type
  TDelphiAIDevCodeCompletionVars = class
  private
    FRelease: Boolean;
    FModule: IOTAModule;
    FLineIni: Integer;
    FLineEnd: Integer;
    FRow: Integer;
    FColumn: Integer;
    FContents: TStrings;
    constructor Create;
  public
    class function GetInstance: TDelphiAIDevCodeCompletionVars;
    destructor Destroy; override;
    procedure Clear;
    property Release: Boolean read FRelease write FRelease;
    property Module: IOTAModule read FModule write FModule;
    property LineIni: Integer read FLineIni write FLineIni;
    property LineEnd: Integer read FLineEnd write FLineEnd;
    property Row: Integer read FRow write FRow;
    property Column: Integer read FColumn write FColumn;
    property Contents: TStrings read FContents write FContents;
  end;

implementation

var
  Instance: TDelphiAIDevCodeCompletionVars;

class function TDelphiAIDevCodeCompletionVars.GetInstance: TDelphiAIDevCodeCompletionVars;
begin
  if not Assigned(Instance) then
    Instance := Self.Create;

  Result := Instance;
end;

constructor TDelphiAIDevCodeCompletionVars.Create;
begin
  FContents := TStringList.Create;
  Self.Clear;
end;

destructor TDelphiAIDevCodeCompletionVars.Destroy;
begin
  FContents.Free;
  inherited;
end;

procedure TDelphiAIDevCodeCompletionVars.Clear;
begin
  FRelease := False;
  FModule := nil;
  FLineIni := 0;
  FLineEnd := 0;
  FRow := 0;
  FColumn := 0;
  FContents.Clear;
end;

initialization

finalization
  if Assigned(Instance) then
    FreeAndNil(Instance);

end.
