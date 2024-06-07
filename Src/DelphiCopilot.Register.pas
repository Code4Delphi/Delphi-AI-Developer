unit DelphiCopilot.Register;

interface

uses
  DelphiCopilot.Chat.View,
  DelphiCopilot.MainMenu.Register;

procedure Register;

implementation

procedure Register;
begin
  DelphiCopilot.Chat.View.RegisterSelf;
  DelphiCopilot.MainMenu.Register.RegisterSelf;
end;

end.
