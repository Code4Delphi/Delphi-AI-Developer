unit DelphiAIDev.DB.Registers.Interfaces;

interface

uses
  System.SysUtils,
  DelphiAIDev.DB.Registers.Fields;

type
  IDelphiAIDevDatabasesModel = interface
    ['{3399A776-4B23-4CFC-8992-568AE07FE065}']
    procedure ReadData(AProc: TProc<TDelphiAIDevDBRegistersFields>);
    procedure SaveOrEditData(AFields: TDelphiAIDevDBRegistersFields);
    procedure RemoveData(const AGuid: string);
  end;

implementation

end.
