unit DelphiAIDev.Register;

interface

uses
  DelphiAIDev.Chat.View,
  DelphiAIDev.DB.Chat.View,
  DelphiAIDev.MainMenu.Register,
  DelphiAIDev.KeyboardBinding,
  DelphiAIDev.PopupMenuProjects,
  DelphiAIDev.IDE.OTAIDENotifier;

procedure Register;

implementation

procedure Register;
begin
  DelphiAIDev.Chat.View.RegisterSelf;
  DelphiAIDev.DB.Chat.View.RegisterSelf;
  DelphiAIDev.MainMenu.Register.RegisterSelf;
  DelphiAIDev.KeyboardBinding.RefreshRegister;
  DelphiAIDev.PopupMenuProjects.RegisterSelf;
  DelphiAIDev.IDE.OTAIDENotifier.RegisterSelf;
end;

end.
