unit DelphiAIDev.DB.Registers.Fields;

interface

uses
  DelphiAIDev.Types;

type
  TDelphiAIDevDBRegistersFields = class
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
    FVendorLib: string;
    FLastReferences: TDateTime;
  public
    constructor Create;
    procedure Clear;
    procedure GetDataFromOtherObject(const AOtherObj: TDelphiAIDevDBRegistersFields);
    property Guid: string read FGuid write FGuid;
    property DriverID: TC4DDriverID read FDriverID write FDriverID;
    property Description: string read FDescription write FDescription;
    property Host: string read FHost write FHost;
    property User: string read FUser write FUser;
    property Password: string read FPassword write FPassword;
    property Port: Integer read FPort write FPort;
    property DatabaseName: string read FDatabaseName write FDatabaseName;
    property Visible: Boolean read FVisible write FVisible;
    property VendorLib: string read FVendorLib write FVendorLib;
    property LastReferences: TDateTime read FLastReferences write FLastReferences;
  end;

implementation

constructor TDelphiAIDevDBRegistersFields.Create;
begin
  Self.Clear;
end;

procedure TDelphiAIDevDBRegistersFields.Clear;
begin
  FGuid := '';
  FDriverID := TC4DDriverID.None;
  FDescription := '';
  FHost := '';
  FUser := '';
  FPassword := '';
  FPort := 0;
  FDatabaseName := '';
  FVisible := True;
  FVendorLib := '';
  FLastReferences := 0;
end;

procedure TDelphiAIDevDBRegistersFields.GetDataFromOtherObject(const AOtherObj: TDelphiAIDevDBRegistersFields);
begin
  FGuid := AOtherObj.Guid;
  FDriverID := AOtherObj.DriverID;
  FDescription := AOtherObj.Description;
  FHost := AOtherObj.Host;
  FUser := AOtherObj.User;
  FPassword := AOtherObj.Password;
  FPort := AOtherObj.Port;
  FDatabaseName := AOtherObj.DatabaseName;
  FVisible := AOtherObj.Visible;
  FVendorLib := AOtherObj.VendorLib;
  FLastReferences := AOtherObj.LastReferences;
end;


end.
