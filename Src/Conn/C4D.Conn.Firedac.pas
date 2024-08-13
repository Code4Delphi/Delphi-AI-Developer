unit C4D.Conn.Firedac;

interface

uses
  {$IFNDEF CONSOLE}
  Firedac.VCLUI.Wait,
  {$ENDIF}
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  Data.DB,
  Firedac.Stan.Intf,
  Firedac.Stan.Option,
  Firedac.Stan.Error,
  Firedac.UI.Intf,
  Firedac.Phys.Intf,
  Firedac.Stan.Def,
  Firedac.Stan.Pool,
  Firedac.Stan.Async,
  Firedac.Phys,
  Firedac.Comp.Client,
  Firedac.DApt,
  Firedac.Comp.UI,
  //FIREBIRD
  FireDAC.Phys.IBBase,
  FireDAC.Phys.FB,
  //MySQL
  Firedac.Phys.MySQLDef,
  Firedac.Phys.MySQL,
  C4D.Conn.Interfaces,
  C4D.Conn.Configs,
  DelphiAIDev.Types,
  DelphiAIDev.Utils;

type
  TC4DConnFiredac = class(TInterfacedObject, IC4DConnection)
  private
    [weak]
    FC4DConnConfigs: TC4DConnConfigs;
    FConnection: TFDConnection;
    FMySQLDriverLink: TFDPhysMySQLDriverLink;
    FFBDriverLink: TFDPhysFBDriverLink;
    function TestFieldsComponentConnection: IC4DConnection;
    procedure ConfigDrivers;
  protected
    function Component: TComponent;
    function Open: IC4DConnection;
    function Close: IC4DConnection;
    function StartTransaction: IC4DConnection;
    function Commit: IC4DConnection;
    function Rollback: IC4DConnection;
    function TestConnection: Boolean;
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
  FConnection.LoginPrompt := False;

  FMySQLDriverLink := TFDPhysMySQLDriverLink.Create(nil);
  FFBDriverLink := TFDPhysFBDriverLink.Create(nil);

  Self.LoadConnectionConfig;
end;

destructor TC4DConnFiredac.Destroy;
begin
  TUtils.ShowMsg('TC4DConnFiredac.Destroy');
  FFBDriverLink.Free;
  FMySQLDriverLink.Free;

  FConnection.Close;
  FreeAndNil(FConnection);

  inherited;
end;

function TC4DConnFiredac.LoadConnectionConfig: IC4DConnection;
begin
  Result := Self;
  FConnection.Close;
  FConnection.Params.Clear;
  FConnection.Params.DriverID := FC4DConnConfigs.DriverID.ToStringID;  //'MySQL';
  FConnection.Params.Database := FC4DConnConfigs.Database;
  FConnection.Params.UserName := FC4DConnConfigs.UserName;
  FConnection.Params.Password := FC4DConnConfigs.Password;
  FConnection.Params.Add('Server=' + FC4DConnConfigs.Host);
  if FC4DConnConfigs.Port > 0 then
    FConnection.Params.Add('Port=' + FC4DConnConfigs.Port.ToString);

//  FConnection.TXOptions.AutoStart := True;
//  FConnection.TXOptions.AutoStop := True;
//  FConnection.TXOptions.AutoCommit := True;
//  FConnection.TxOptions.StopOptions := [xoIfAutoStarted, xoFinishRetaining];
//  FConnection.UpdateOptions.AutoCommitUpdates := True;
//  FConnection.UpdateOptions.RefreshMode := rmAll;

  Self.ConfigDrivers;
end;

procedure TC4DConnFiredac.ConfigDrivers;
begin
  FMySQLDriverLink.VendorLib := '';
  FFBDriverLink.VendorLib := '';

  case FC4DConnConfigs.DriverID of
    TC4DDriverID.MySQL:
      FMySQLDriverLink.VendorLib := FC4DConnConfigs.VendorLib;
    TC4DDriverID.Firebird:
      FFBDriverLink.VendorLib := FC4DConnConfigs.VendorLib;
  end;
end;

function TC4DConnFiredac.Component: TComponent;
begin
  Result := FConnection;
end;

function TC4DConnFiredac.Open: IC4DConnection;
begin
  Result := Self;
  Self.TestFieldsComponentConnection;
  FConnection.Open;
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
    Self.LoadConnectionConfig;
    LConnectedOld := FConnection.Connected;
    FConnection.Close; //
    FConnection.Open;
    Result := FConnection.Connected;

    if FConnection.Connected <> LConnectedOld then
      FConnection.Connected := LConnectedOld;
  except
    on E: exception do
      raise exception.Create('Unsuccessful Connection! ' + sLineBreak + E.Message);
  end;
end;

function TC4DConnFiredac.TestFieldsComponentConnection: IC4DConnection;
var
  LEmptyFields: string;
begin
  Result := Self;

  LEmptyFields := '';
  if FC4DConnConfigs.Database.Trim.IsEmpty then
    LEmptyFields := LEmptyFields + 'Host. ';

  if FConnection.Params.UserName.Trim.IsEmpty then
    LEmptyFields := LEmptyFields + 'UserName. ';

  if FConnection.Params.Password.Trim.IsEmpty then
    LEmptyFields := LEmptyFields + 'Password. ';

  if Trim(FConnection.Params.Database).IsEmpty then
    LEmptyFields := LEmptyFields + 'Database.';

  if not LEmptyFields.Trim.IsEmpty then
    raise exception.Create('To connect to the database, the following data must be filled in: ' + LEmptyFields);
end;

end.
