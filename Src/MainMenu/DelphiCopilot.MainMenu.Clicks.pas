unit DelphiCopilot.MainMenu.Clicks;

interface

uses
  System.SysUtils,
  System.Classes,
  VCL.Forms,
  ToolsAPI;

type
  TDelphiCopilotIDEMainMenuClicks = class
  private

  public
    class procedure ChatClick(Sender: TObject);
    class procedure AboutClick(Sender: TObject);
  end;

implementation

uses
  DelphiCopilot.Utils,
  DelphiCopilot.Utils.OTA,
  DelphiCopilot.Chat.View,
  DelphiCopilot.View.About;


class procedure TDelphiCopilotIDEMainMenuClicks.ChatClick(Sender: TObject);
begin
  DelphiCopilot.Chat.View.DelphiCopilotChatViewShowDockableForm;
end;

class procedure TDelphiCopilotIDEMainMenuClicks.AboutClick(Sender: TObject);
begin
  DelphiCopilotViewAbout := TDelphiCopilotViewAbout.Create(nil);
  try
    DelphiCopilotViewAbout.ShowModal;
  finally
    FreeAndNil(DelphiCopilotViewAbout);
  end;
end;

end.
