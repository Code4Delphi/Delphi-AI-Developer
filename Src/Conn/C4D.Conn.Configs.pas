unit C4D.Conn.Configs;

interface

uses
  System.SysUtils,
  System.Classes,
  C4D.Conn.Types,
  DelphiAIDev.Types;

type
  TC4DConnConfigs = class
  private
    FComponentConnection: TComponentConnection;
    FDriverID: TC4DDriverID;
    FHost: string;
    FUserName: string;
    FPassword: string;
    FDatabase: string;
    FPort: Integer;
    FVendorLib: string;
    procedure Clear;
  public
    constructor Create;
    destructor Destroy; override;
    function ComponentConnection: TComponentConnection;
    function DriverID: TC4DDriverID; overload;
    function DriverID(Value: TC4DDriverID): TC4DConnConfigs; overload;
    function Host: string; overload;
    function Host(Value: string): TC4DConnConfigs; overload;
    function UserName: string; overload;
    function UserName(Value: string): TC4DConnConfigs; overload;
    function Password: string; overload;
    function Password(Value: string): TC4DConnConfigs; overload;
    function Database: string; overload;
    function Database(Value: string): TC4DConnConfigs; overload;
    function Port: Integer; overload;
    function Port(Value: Integer): TC4DConnConfigs; overload;
    function VendorLib: string; overload;
    function VendorLib(Value: string): TC4DConnConfigs; overload;
    function TestFieldFilling: TC4DConnConfigs;
  end;

implementation

constructor TC4DConnConfigs.Create;
begin
  Self.Clear;

  {$IFDEF C4D_ZEOS}
    FComponentConnection := TComponentConnection.Zeos;
  {$ELSE}
    FComponentConnection := TComponentConnection.FireDac;
  {$ENDIF}
end;

destructor TC4DConnConfigs.Destroy;
begin
  inherited;
end;

procedure TC4DConnConfigs.Clear;
begin
  FDriverID := TC4DDriverID.None;;
  FHost := '';
  FUserName := '';
  FPassword := '';
  FDatabase := '';
  FPort := 0;
  FVendorLib := '';
end;

function TC4DConnConfigs.ComponentConnection: TComponentConnection;
begin
  if FComponentConnection = TComponentConnection.Empty then
    raise Exception.Create('Component for connection to the bank not informed');

  Result := FComponentConnection;
end;

function TC4DConnConfigs.DriverID: TC4DDriverID;
begin
  Result := FDriverID;
end;

function TC4DConnConfigs.DriverID(Value: TC4DDriverID): TC4DConnConfigs;
begin
  Result := Self;
  FDriverID := Value;
end;

function TC4DConnConfigs.Host: string;
begin
  Result := FHost;
end;

function TC4DConnConfigs.Host(Value: string): TC4DConnConfigs;
begin
  Result := Self;
  FHost := Value;
end;

function TC4DConnConfigs.UserName: string;
begin
  Result := FUserName;
end;

function TC4DConnConfigs.UserName(Value: string): TC4DConnConfigs;
begin
  Result := Self;
  FUserName := Value;
end;

function TC4DConnConfigs.Password: string;
begin
  Result := FPassword;
end;

function TC4DConnConfigs.Password(Value: string): TC4DConnConfigs;
begin
  Result := Self;
  FPassword := Value;
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

function TC4DConnConfigs.Port: Integer;
begin
  Result := FPort;
end;

function TC4DConnConfigs.Port(Value: Integer): TC4DConnConfigs;
begin
  Result := Self;
  FPort := Value;
end;

function TC4DConnConfigs.VendorLib: string;
begin
  Result := FVendorLib;
end;

function TC4DConnConfigs.VendorLib(Value: string): TC4DConnConfigs;
begin
  Result := Self;
  FVendorLib := Value;
end;

function TC4DConnConfigs.TestFieldFilling: TC4DConnConfigs;
var
  LTemp: string;
begin
  Result := Self;
  LTemp := '';

  if FDriverID = TC4DDriverID.None then
    LTemp := LTemp + 'Driver ID. ';

  if FHost.Trim.IsEmpty then
    LTemp := LTemp + 'Host. ';

  if FUserName.Trim.IsEmpty  then
    LTemp := LTemp + 'User. ';

  if FPassword.Trim.IsEmpty then
    LTemp := LTemp + 'Password. ';

  if FDatabase.Trim.IsEmpty then
    LTemp := LTemp + 'Database name.';

  if not LTemp.Trim.IsEmpty then
    raise Exception.Create('To connect to the database, the following data must be filled in: ' + LTemp);
end;

end.
