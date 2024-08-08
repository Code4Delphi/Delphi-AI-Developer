unit DelphiAIDev.Databases.Interfaces;

interface

uses
  System.SysUtils,
  DelphiAIDev.Databases.Fields;

type
  IDelphiAIDevDatabasesModel = interface
    ['{3399A776-4B23-4CFC-8992-568AE07FE065}']
    procedure ReadData(AProc: TProc<TDelphiAIDevDatabasesFields>);
    procedure SaveOrEditData(const AFields: TDelphiAIDevDatabasesFields);
    procedure RemoveData(const AGuid: string);
  end;

implementation

end.
