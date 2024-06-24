unit DelphiAIDev.DefaultsQuestions.Interfaces;

interface

uses
  System.SysUtils,
  DelphiAIDev.DefaultsQuestions.Model;

type
  IDelphiAIDevDefaultsQuestionsDao = interface
    ['{3399A776-4B23-4CFC-8992-568AE07FE065}']
    procedure ReadData(AProc: TProc<TDelphiAIDevDefaultsQuestionsModel>);
  end;

implementation

end.
