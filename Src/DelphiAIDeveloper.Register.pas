unit DelphiAIDeveloper.Register;

interface

uses
  DelphiAIDev.Chat.View,
  DelphiAIDev.MainMenu.Register;

procedure Register;

implementation

procedure Register;
begin
  DelphiAIDev.Chat.View.RegisterSelf;
  DelphiAIDev.MainMenu.Register.RegisterSelf;
end;

end.
