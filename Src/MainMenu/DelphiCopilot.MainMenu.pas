unit DelphiCopilot.MainMenu;

interface

uses
  System.SysUtils,
  System.Classes,
  VCL.Menus,
  ToolsAPI,
  DelphiCopilot.Interfaces;

type
  TC4DWizardIDEMainMenu = class(TInterfacedObject, IDelphiCopilotIDEMainMenu)
  private
    FMainMenuIDE: TMainMenu;
    FMenuItemC4D: TMenuItem;
    constructor Create;
    procedure CreateMenuCode4DelphiInIDEMenu;
    function CreateSubMenu(AName: string; ACaption: string; AOnClick: TNotifyEvent; AImgIndex: Integer = -1; AShortCutStr: string = ''): TMenuItem;
  protected
    procedure CreateMenus;
  public
    class function GetInstance: IDelphiCopilotIDEMainMenu;
    destructor Destroy; override;
  end;

implementation

uses
  DelphiCopilot.Consts,
  DelphiCopilot.Utils,
  DelphiCopilot.Utils.OTA,
  DelphiCopilot.MainMenu.Clicks;

var
  Instance: IDelphiCopilotIDEMainMenu;

class function TC4DWizardIDEMainMenu.GetInstance: IDelphiCopilotIDEMainMenu;
begin
  if(not Assigned(Instance))then
    Instance := Self.Create;
  Result := Instance;
end;

constructor TC4DWizardIDEMainMenu.Create;
begin
  FMainMenuIDE := TDelphiCopilotUtilsOTA.GetINTAServices.MainMenu;
end;

destructor TC4DWizardIDEMainMenu.Destroy;
begin
  if(Assigned(FMenuItemC4D))then
    FreeAndNil(FMenuItemC4D);
  inherited;
end;

procedure TC4DWizardIDEMainMenu.CreateMenus;
begin
  Self.CreateMenuCode4DelphiInIDEMenu;

  Self.CreateSubMenu(TC4DConsts.MENU_IDE_NOTES_NAME,
    TC4DConsts.MENU_IDE_NOTES_CAPTION,
    TC4DWizardIDEMainMenuClicks.ChatClick,
    -1 //TC4DWizardIDEImageListMain.GetInstance.ImgIndexNotes,
    );

  Self.CreateSubMenu('C4DSeparator50', '-', nil);

  Self.CreateSubMenu('C4DSeparator90', '-', nil);
  Self.CreateSubMenu(TC4DConsts.MENU_IDE_ABOUT_NAME,
    TC4DConsts.MENU_IDE_ABOUT_CAPTION,
    TC4DWizardIDEMainMenuClicks.AboutClick,
    -1 //TC4DWizardIDEImageListMain.GetInstance.ImgIndexC4D_Logo
    );
end;

procedure TC4DWizardIDEMainMenu.CreateMenuCode4DelphiInIDEMenu;
var
  LMenuItemTabs: TMenuItem;
  LMenuItemTools: TMenuItem;
begin
  FMenuItemC4D := TMenuItem(FMainMenuIDE.FindComponent(TC4DConsts.ITEM_MENU_Code4D_NAME));
  if(Assigned(FMenuItemC4D))then
    FreeAndNil(FMenuItemC4D);

  FMenuItemC4D := TMenuItem.Create(FMainMenuIDE);
  FMenuItemC4D.Name := TC4DConsts.ITEM_MENU_Code4D_NAME;
  FMenuItemC4D.Caption := TC4DConsts.ITEM_MENU_Code4D_CAPTION;

  LMenuItemTabs := FMainMenuIDE.Items.Find('Tabs');
  if(Assigned(LMenuItemTabs))then
  begin
    FMainMenuIDE.Items.Insert(FMainMenuIDE.Items.IndexOf(LMenuItemTabs), FMenuItemC4D);
    Exit;
  end;

  LMenuItemTools := FMainMenuIDE.Items.Find('Tools');
  if(Assigned(LMenuItemTools))then
  begin
    FMainMenuIDE.Items.Insert(FMainMenuIDE.Items.IndexOf(LMenuItemTools) + 1, FMenuItemC4D);
    Exit;
  end;

  FMainMenuIDE.Items.Add(FMenuItemC4D);
end;

function TC4DWizardIDEMainMenu.CreateSubMenu(AName: string; ACaption: string; AOnClick: TNotifyEvent; AImgIndex: Integer = -1; AShortCutStr: string = ''): TMenuItem;
var
  LMenuItem: TMenuItem;
begin
  LMenuItem := TMenuItem.Create(FMenuItemC4D);
  LMenuItem.Name := AName;
  LMenuItem.Caption := ACaption;
  LMenuItem.OnClick := AOnClick;
  LMenuItem.ImageIndex := AImgIndex;
  LMenuItem.ShortCut := TextToShortCut(TDelphiCopilotUtils.RemoveSpacesAll(AShortCutStr));
  FMenuItemC4D.Add(LMenuItem);
  Result := LMenuItem;
end;

initialization

finalization
  if(Assigned(Instance))then
    Instance := nil;

end.
