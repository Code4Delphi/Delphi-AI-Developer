unit DelphiAIDev.AI.Interfaces;

interface

type
  IDelphiAIDevAI = interface
    ['{B82FACA6-66DA-4DC0-877F-8263B5C172C1}']
    function GetResponse(const AQuestion: string): string;
  end;

implementation

end.
