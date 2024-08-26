unit DelphiAIDev.Projects.Interfaces;

interface

uses
  System.SysUtils,
  DelphiAIDev.Types,
  DelphiAIDev.Projects.Fields;

type
  IDelphiAIDevProjectsModel = interface
    ['{D919A407-4301-447F-A267-6965153DC01A}']
    function ReadGuid(const AGuid: string): TDelphiAIDevProjectsFields;
    function ReadFilePathCurrentProject: TDelphiAIDevProjectsFields;
    function ReadFilePath(const AFilePath: string): TDelphiAIDevProjectsFields;
    procedure ReadData(AProc: TProc<TDelphiAIDevProjectsFields>; const AAutoFreeField: TAutoFreeField = TAutoFreeField.Yes);
    procedure SaveOrEditData(AFields: TDelphiAIDevProjectsFields);
    procedure RemoveData(const AGuid: string);
  end;

implementation

end.
