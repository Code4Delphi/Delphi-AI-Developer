unit DelphiAIDev.MainMenu.Clicks;

interface

uses
  System.SysUtils,
  System.Classes,
  VCL.Forms,
  ToolsAPI;

type
  TDelphiAIDevIDEMainMenuClicks = class
  private
  public
    class procedure ChatClick(Sender: TObject);
    class procedure DefaultsQuestionsClick(Sender: TObject);
    class procedure SettingsClick(Sender: TObject);
    class procedure AboutClick(Sender: TObject);
  end;

implementation

uses
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA,
  DelphiAIDev.Chat.View,
  DelphiAIDev.DefaultsQuestions.View,
  DelphiAIDev.Settings.View,
  DelphiAIDev.View.About;


class procedure TDelphiAIDevIDEMainMenuClicks.ChatClick(Sender: TObject);
begin
  DelphiAIDev.Chat.View.DelphiAIDevChatViewShowDockableForm;
end;

class procedure TDelphiAIDevIDEMainMenuClicks.DefaultsQuestionsClick(Sender: TObject);
begin
  DelphiAIDev.DefaultsQuestions.View.DelphiAIDevDefaultsQuestionsViewShow;
end;

class procedure TDelphiAIDevIDEMainMenuClicks.SettingsClick(Sender: TObject);
begin
  DelphiAIDevSettingsView := TDelphiAIDevSettingsView.Create(nil);
  try
    DelphiAIDevSettingsView.ShowModal;
  finally
    FreeAndNil(DelphiAIDevSettingsView);
  end;
end;

class procedure TDelphiAIDevIDEMainMenuClicks.AboutClick(Sender: TObject);
begin
  DelphiAIDevViewAbout := TDelphiAIDevViewAbout.Create(nil);
  try
    DelphiAIDevViewAbout.ShowModal;
  finally
    FreeAndNil(DelphiAIDevViewAbout);
  end;
end;

end.
