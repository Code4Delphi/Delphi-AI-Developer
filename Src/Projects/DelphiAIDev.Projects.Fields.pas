unit DelphiAIDev.Projects.Fields;

interface

uses
  DelphiAIDev.Types;

type
  TDelphiAIDevProjectsFields = class
  private
    FGuid: string;
    FFilePath: string;
    FNickname: string;
    FGuidDatabaseDefault: string;
  public
    constructor Create;
    procedure Clear;
    procedure GetDataFromOtherObject(const AOtherObj: TDelphiAIDevProjectsFields);
    property Guid: string read FGuid write FGuid;
    property FilePath: string read FFilePath write FFilePath;
    property Nickname: string read FNickname write FNickname;
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
  FNickname := '';
  FGuidDatabaseDefault := '';
end;

procedure TDelphiAIDevProjectsFields.GetDataFromOtherObject(const AOtherObj: TDelphiAIDevProjectsFields);
begin
  FGuid := AOtherObj.Guid;
  FNickname := AOtherObj.Nickname;
  FFilePath := AOtherObj.FilePath;
  FGuidDatabaseDefault := AOtherObj.GuidDatabaseDefault;
end;

end.
