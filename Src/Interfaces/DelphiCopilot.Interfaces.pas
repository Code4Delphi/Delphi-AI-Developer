unit DelphiCopilot.Interfaces;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  DelphiCopilot.Types;

type
  IDelphiCopilotIDEMainMenu = interface
    ['{AE2F4702-14B1-42A1-A791-CEBCAAF519E1}']
    procedure CreateMenus;
  end;

  IDelphiCopilotOneUseForLine = interface
    ['{BAB5ACC2-7CCC-435B-A237-4730BF0B2944}']
    procedure Process;
  end;

  IDelphiCopilotAbout = interface
    ['{D0120219-6F60-4047-893F-23B8E7D2AFA0}']
    procedure Show;
  end;

implementation

end.
