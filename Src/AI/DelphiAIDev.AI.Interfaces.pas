unit DelphiAIDev.AI.Interfaces;

interface

uses
  System.Classes;

type
  IDelphiAIDevAIResponse = interface
    ['{F9E7734A-33FA-4448-9F5D-A3680FFFFFB9}']
    function Clear: IDelphiAIDevAIResponse;
    function SetStatusCode(const Value: Integer): IDelphiAIDevAIResponse;
    function GetStatusCode: Integer;
    function SetContentText(const Value: string): IDelphiAIDevAIResponse;
    function GetContent: TStrings;
  end;

  IDelphiAIDevAI = interface
    ['{B82FACA6-66DA-4DC0-877F-8263B5C172C1}']
    function GetResponse(const AQuestion: string): IDelphiAIDevAIResponse;
  end;

implementation

end.
