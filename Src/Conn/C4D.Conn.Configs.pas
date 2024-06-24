unit C4D.Conn.Configs;

interface

uses
  System.SysUtils,
  System.Classes,
  IniFiles,
  C4D.Conn.Types;

type
  TC4DConnConfigs = class
  private
    FComponentConnection: TComponentConnection;
    FConnectionSingleton: Boolean;
    FDatabase: string;
  public
    class function New: TC4DConnConfigs;
    constructor Create;
    destructor Destroy; override;
    function ComponentConnection: TComponentConnection;
    {$IFDEF C4DConnZeos}
    function ComponentConnectionZeos: TC4DConnConfigs;
    {$ENDIF}
    function ComponentConnectionFireDac: TC4DConnConfigs;
    function ConnectionSingleton: Boolean;
    function ConnectionSingletonON: TC4DConnConfigs;
    function ConnectionSingletonOFF: TC4DConnConfigs;
    function Database: string; overload;
    function Database(Value: string): TC4DConnConfigs; overload;
    procedure CarregaDadosDeArqIni(const AFileNameIni: string);
  end;

implementation

class function TC4DConnConfigs.New: TC4DConnConfigs;
begin
  Result := Self.Create;
end;

constructor TC4DConnConfigs.Create;
begin
  FConnectionSingleton := True;
  FComponentConnection := TComponentConnection.Empty;
end;

destructor TC4DConnConfigs.Destroy;
begin
  inherited;
end;

function TC4DConnConfigs.ComponentConnection: TComponentConnection;
begin
  if FComponentConnection = TComponentConnection.Empty then
    raise Exception.Create('Database connection component not specified');
  Result := FComponentConnection;
end;

{$IFDEF C4DConnZeos}
function TC4DConnConfigs.ComponentConnectionZeos: TC4DConnConfigs;
begin
  Result := Self;
  if(FComponentConnection <> TComponentConnection.Empty)then
    raise Exception.Create('Connection component has already been provided');

  FComponentConnection := TComponentConnection.Zeos;
end;
{$ENDIF}

function TC4DConnConfigs.ComponentConnectionFireDac: TC4DConnConfigs;
begin
  Result := Self;
  if(FComponentConnection <> TComponentConnection.Empty)then
    raise Exception.Create('Connection component has already been provided');
  FComponentConnection := TComponentConnection.FireDac;
end;

function TC4DConnConfigs.ConnectionSingleton: Boolean;
begin
  Result := FConnectionSingleton;
end;

function TC4DConnConfigs.ConnectionSingletonON: TC4DConnConfigs;
begin
  Result := Self;
  FConnectionSingleton := True;
end;

function TC4DConnConfigs.ConnectionSingletonOFF: TC4DConnConfigs;
begin
  Result := Self;
  FConnectionSingleton := False;
end;

function TC4DConnConfigs.Database: string;
begin
  Result := FDatabase;
end;

function TC4DConnConfigs.Database(Value: string): TC4DConnConfigs;
begin
  Result := Self;
  FDatabase := Value;
end;

procedure TC4DConnConfigs.CarregaDadosDeArqIni(const AFileNameIni: string);
var
  LIniFile: TIniFile;
begin
  if AFileNameIni.Trim.IsEmpty then
    raise Exception.Create('Database access configuration file not provided.');

  if not FileExists(AFileNameIni) then
    raise Exception.Create('Configuration file for database access not found.: ' + AFileNameIni);

  try
    LIniFile := TIniFile.Create(AFileNameIni);
    try
      FDatabase := LIniFile.ReadString('ConnData01', 'Database', FDatabase);
    finally
      LIniFile.Free;
    end;

    if FDatabase.Trim.IsEmpty then
      raise Exception.Create('Data not found in ini file (Database name)');

    if not FileExists(FDatabase.Trim) then
      raise Exception.Create('Arquivo do banco de dados não encontrado');

  except
    on E: Exception do
      raise Exception.Create('An exception occurred while fetching data for the database connection. ' + sLineBreak +
        'File: ' + AFileNameIni + sLineBreak +
        'Message: ' + E.Message);
  end;
end;

end.
