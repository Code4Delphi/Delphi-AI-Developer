unit DelphiAIDev.Register;

interface

uses
  DelphiAIDev.Chat.View,
  DelphiAIDev.MainMenu.Register,
  DelphiAIDev.IDE.Shortcuts,
  DelphiAIDev.PopupMenuProjects;

procedure Register;

implementation

procedure Register;
begin
  DelphiAIDev.Chat.View.RegisterSelf;
  DelphiAIDev.MainMenu.Register.RegisterSelf;
  DelphiAIDev.IDE.Shortcuts.RefreshRegister;
  DelphiAIDev.PopupMenuProjects.RegisterSelf;
end;

end.
