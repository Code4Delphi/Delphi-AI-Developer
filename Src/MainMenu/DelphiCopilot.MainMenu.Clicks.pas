unit DelphiCopilot.MainMenu.Clicks;

interface

uses
  System.SysUtils,
  System.Classes,
  VCL.Forms,
  ToolsAPI;

type
  TC4DWizardIDEMainMenuClicks = class
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


class procedure TC4DWizardIDEMainMenuClicks.ChatClick(Sender: TObject);
begin
  DelphiCopilot.Chat.View.DelphiCopilotChatViewShowDockableForm;
end;

class procedure TC4DWizardIDEMainMenuClicks.AboutClick(Sender: TObject);
begin
  DelphiCopilotViewAbout := TDelphiCopilotViewAbout.Create(nil);
  try
    DelphiCopilotViewAbout.ShowModal;
  finally
    FreeAndNil(DelphiCopilotViewAbout);
  end;
end;

end.
