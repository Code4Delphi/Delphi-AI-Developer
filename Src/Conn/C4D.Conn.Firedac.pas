unit C4D.Conn.Firedac;

interface

uses
  {$IFNDEF CONSOLE}
  Firedac.VCLUI.Wait,
  {$ENDIF}
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  Firedac.Stan.Intf,
  Firedac.Stan.Option,
  Firedac.Stan.Error,
  Firedac.UI.Intf,
  Firedac.Phys.Intf,
  Firedac.Stan.Def,
  Firedac.Stan.Pool,
  Firedac.Stan.Async,
  Firedac.Phys,
  Data.DB,
  Firedac.Comp.Client,
  Firedac.DApt,
  Firedac.Comp.UI,
  Firedac.Phys.MySQLDef,
  Firedac.Phys.MySQL,
  C4D.Conn.Interfaces,
  C4D.Conn.Configs;

type
  TC4DConnFiredac = class(TInterfacedObject, IC4DConnection)
  private
    [weak]
    FC4DConnConfigs: TC4DConnConfigs;
    FConnection: TFDConnection;
    function TestFieldsComponentConnection: IC4DConnection;
  protected
    function Component: TComponent;
    function Open: IC4DConnection;
    function Close: IC4DConnection;
    function StartTransaction: IC4DConnection;
    function Commit: IC4DConnection;
    function Rollback: IC4DConnection;
    function TestConnection: Boolean;
    function TestConnectionOnly: Boolean;
    function LoadConnectionConfig: IC4DConnection;
  public
    class function New(AC4DConnConfigs: TC4DConnConfigs): IC4DConnection;
    constructor Create(AC4DConnConfigs: TC4DConnConfigs);
    destructor Destroy; override;
  end;

implementation

class function TC4DConnFiredac.New(AC4DConnConfigs: TC4DConnConfigs): IC4DConnection;
begin
  Result := Self.Create(AC4DConnConfigs);
end;

constructor TC4DConnFiredac.Create(AC4DConnConfigs: TC4DConnConfigs);
begin
  FC4DConnConfigs := AC4DConnConfigs;
  FConnection := TFDConnection.Create(nil);
  Self.LoadConnectionConfig;
end;

destructor TC4DConnFiredac.Destroy;
begin
  FConnection.Close;
  FreeAndNil(FConnection);
  inherited;
end;

function TC4DConnFiredac.LoadConnectionConfig: IC4DConnection;
begin
  Result := Self;
  FConnection.Close;
  FConnection.LoginPrompt := False;
  FConnection.Params.Clear;
  FConnection.Params.DriverID := 'SQLite';
  FConnection.Params.Database := FC4DConnConfigs.Database;
end;

function TC4DConnFiredac.Component: TComponent;
begin
  Result := FConnection;
end;

function TC4DConnFiredac.Open: IC4DConnection;
begin
  Result := Self;
  Self.TestFieldsComponentConnection;
  FConnection.Connected := True;
end;

function TC4DConnFiredac.Close: IC4DConnection;
begin
  Result := Self;
  FConnection.Close;
end;

function TC4DConnFiredac.StartTransaction: IC4DConnection;
begin
  FConnection.StartTransaction;
end;

function TC4DConnFiredac.Commit: IC4DConnection;
begin
  FConnection.Commit;
end;

function TC4DConnFiredac.Rollback: IC4DConnection;
begin
  FConnection.Rollback;
end;

function TC4DConnFiredac.TestConnection: Boolean;
var
  LConnectedOld: Boolean;
begin
  Self.TestFieldsComponentConnection;
  try
    LConnectedOld := FConnection.Connected;
    FConnection.Connected := True;
    Result := FConnection.Connected;
    if(FConnection.Connected <> LConnectedOld)then
      FConnection.Connected := LConnectedOld;
  except
    on E: exception do
      raise exception.Create('Database connection cannot be established: ' + E.Message);
  end;
end;

function TC4DConnFiredac.TestConnectionOnly: Boolean;
var
  LConnectedOld: Boolean;
begin
  Result := False;
  try
    LConnectedOld := FConnection.Connected;
    FConnection.Connected := True;
    Result := FConnection.Connected;
    if(FConnection.Connected <> LConnectedOld)then
      FConnection.Connected := LConnectedOld;
  except
  end;
end;

function TC4DConnFiredac.TestFieldsComponentConnection: IC4DConnection;
begin
  Result := Self;

  if Trim(FConnection.Params.Database).IsEmpty then
    raise exception.Create('Enter the Database field');
end;

end.
