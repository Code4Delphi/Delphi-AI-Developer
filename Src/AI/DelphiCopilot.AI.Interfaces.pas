unit DelphiCopilot.AI.Interfaces;

interface

type
  IDelphiCopilotAI = interface
    ['{2B55607E-0A53-469F-8E63-FA467BFD021B}']
    function GetResponse(const AQuestion: string): string;
  end;

implementation

end.
