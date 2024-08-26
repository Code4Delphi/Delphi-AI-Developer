unit DelphiAIDev.Projects.Fields;

interface

uses
  DelphiAIDev.Types;

type
  TDelphiAIDevProjectsFields = class
  private
    FGuid: string;
    FFilePath: string;
    FDescription: string;
    FGuidDatabaseDefault: string;
  public
    constructor Create;
    procedure Clear;
    procedure GetDataFromOtherObject(const AOtherObj: TDelphiAIDevProjectsFields);
    property Guid: string read FGuid write FGuid;
    property FilePath: string read FFilePath write FFilePath;
    property Description: string read FDescription write FDescription;
    property GuidDatabaseDefault: string read FGuidDatabaseDefault write FGuidDatabaseDefault;
  end;

implementation

constructor TDelphiAIDevProjectsFields.Create;
begin
  Self.Clear;
end;

procedure TDelphiAIDevProjectsFields.Clear;
begin
  FGuid := '';
  FFilePath := '';
  FDescription := '';
  FGuidDatabaseDefault := '';
end;

procedure TDelphiAIDevProjectsFields.GetDataFromOtherObject(const AOtherObj: TDelphiAIDevProjectsFields);
begin
  FGuid := AOtherObj.Guid;
  FDescription := AOtherObj.Description;
  FFilePath := AOtherObj.FilePath;
  FGuidDatabaseDefault := AOtherObj.GuidDatabaseDefault;
end;

end.
