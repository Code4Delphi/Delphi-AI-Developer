unit DelphiAIDev.Register;

interface

uses
  DelphiAIDev.Chat.View,
  DelphiAIDev.MainMenu.Register,
  DelphiAIDev.KeyboardBinding,
  DelphiAIDev.PopupMenuProjects,
  DelphiAIDev.DB.Chat.View;

procedure Register;

implementation

procedure Register;
begin
  DelphiAIDev.Chat.View.RegisterSelf;
  DelphiAIDev.MainMenu.Register.RegisterSelf;
  DelphiAIDev.KeyboardBinding.RefreshRegister;
  DelphiAIDev.PopupMenuProjects.RegisterSelf;
  DelphiAIDev.DB.Chat.View.RegisterSelf;
end;

end.
