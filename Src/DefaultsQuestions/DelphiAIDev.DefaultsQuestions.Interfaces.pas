unit DelphiAIDev.DefaultsQuestions.Interfaces;

interface

uses
  System.SysUtils,
  DelphiAIDev.DefaultsQuestions.Fields;

type
  IDelphiAIDevDefaultsQuestionsModel = interface
    ['{3399A776-4B23-4CFC-8992-568AE07FE065}']
    procedure ReadData(AProc: TProc<TDelphiAIDevDefaultsQuestionsFields>);
    procedure SaveOrEditData(const AFields: TDelphiAIDevDefaultsQuestionsFields);
    procedure RemoveData(const AGuid: string);
  end;

implementation

end.
