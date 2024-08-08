unit DelphiAIDev.Databases.Fields;

interface

uses
  DelphiAIDev.Types;

type
  TDelphiAIDevDatabasesFields = class
  private
    FGuid: string;
    FDriverID: TC4DDriverID;
    FDescription: string;
    FHost: string;
    FUser: string;
    FPassword: string;
    FPort: Integer;
    FDatabaseName: string;
    FVisible: Boolean;
  public
    constructor Create;
    procedure Clear;

    property Guid: string read FGuid write FGuid;
    property DriverID: TC4DDriverID read FDriverID write FDriverID;
    property Description: string read FDescription write FDescription;
    property Host: string read FHost write FHost;
    property User: string read FUser write FUser;
    property Password: string read FPassword write FPassword;
    property Port: Integer read FPort write FPort;
    property DatabaseName: string read FDatabaseName write FDatabaseName;
    property Visible: Boolean read FVisible write FVisible;
  end;

implementation

constructor TDelphiAIDevDatabasesFields.Create;
begin
  Self.Clear;
end;

procedure TDelphiAIDevDatabasesFields.Clear;
begin
  FGuid := '';
  FDriverID := TC4DDriverID.MySQL;
  FDescription := '';
  FHost := '';
  FUser := '';
  FPassword := '';
  FPort := 0;
  FDatabaseName := '';
  FVisible := True;
end;

end.
