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
    ['{897CE9C0-D54E-4F53-AD8C-AE68E26B2F8C}']
    procedure CreateMenus;
  end;

  IDelphiAIDevOneUseForLine = interface
    ['{806F6BB9-0D97-4C01-8EE8-35BB9E13ACE3}']
    procedure Process;
  end;

  IDelphiAIDevAbout = interface
    ['{CE7562A6-5060-4BF1-98D0-0AA50B41ACCA}']
    procedure Show;
  end;

implementation

end.
