unit DelphiAIDev.Interfaces;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  DelphiAIDev.Types;

type
  IDelphiAIDevIDEMainMenu = interface
    ['{AE2F4702-14B1-42A1-A791-CEBCAAF519E1}']
    procedure CreateMenus;
  end;

  IDelphiAIDevOneUseForLine = interface
    ['{BAB5ACC2-7CCC-435B-A237-4730BF0B2944}']
    procedure Process;
  end;

  IDelphiAIDevAbout = interface
    ['{D0120219-6F60-4047-893F-23B8E7D2AFA0}']
    procedure Show;
  end;

implementation

end.
