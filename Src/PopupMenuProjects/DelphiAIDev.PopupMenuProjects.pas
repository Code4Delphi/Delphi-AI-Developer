unit DelphiAIDev.PopupMenuProjects;

interface

uses
  System.SysUtils,
  System.Classes,
  ToolsAPI,
  DelphiAIDev.Types,
  DelphiAIDev.PopupMenuProjects.Item,
  DelphiAIDev.PopupMenuProjects.OnExecute;

type
  TC4DWizardIDEPopupMenuNotifier = class(TNotifierObject, IOTAProjectMenuItemCreatorNotifier)
  private
    FOnExecute: TDelphiAIDevPopupMenuProjectsOnExecute;
    FIOTAProject: IOTAProject;
    FPosition: Integer;
    function AddItemInMenu(const ACaption: string): IOTAProjectManagerMenu;
    function AddSubItemInMenu(const ACaption: string; const AOnExecute: TC4DWizardMenuContextList = nil;
      const AChecked: Boolean = False): IOTAProjectManagerMenu;
  protected
    procedure AddMenu(const Project: IOTAProject; const IdentList: TStrings;
      const ProjectManagerMenuList: IInterfaceList; IsMultiSelect: Boolean);
  public
    class function New: IOTAProjectMenuItemCreatorNotifier;
    constructor Create;
    destructor Destroy; override;
  end;

procedure RegisterSelf;

implementation

uses
  DelphiAIDev.Consts,
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA;

var
  Index: Integer = -1;

procedure RegisterSelf;
begin
  Index := TUtilsOTA
    .GetIOTAProjectManager
    .AddMenuItemCreatorNotifier(TC4DWizardIDEPopupMenuNotifier.New);
end;

class function TC4DWizardIDEPopupMenuNotifier.New: IOTAProjectMenuItemCreatorNotifier;
begin
  Result := Self.Create;
end;

constructor TC4DWizardIDEPopupMenuNotifier.Create;
begin
  FOnExecute := TDelphiAIDevPopupMenuProjectsOnExecute.Create;
end;

destructor TC4DWizardIDEPopupMenuNotifier.Destroy;
begin
  FOnExecute.Free;
  inherited;
end;

procedure TC4DWizardIDEPopupMenuNotifier.AddMenu(const Project: IOTAProject; const IdentList: TStrings;
  const ProjectManagerMenuList: IInterfaceList; IsMultiSelect: Boolean);
begin
  if not Assigned(ProjectManagerMenuList) then
    Exit;

  if IdentList.IndexOf(sProjectContainer) >= 0 then
    FPosition := pmmpUninstall
  else if IdentList.IndexOf(sProjectGroupContainer) >= 0 then
    FPosition := pmmpRename
  else
    Exit;

  FIOTAProject := Project;
  FOnExecute.OTAProject := FIOTAProject;

  FPosition := FPosition + 201;
  ProjectManagerMenuList.Add(Self.AddItemInMenu('-'));
  ProjectManagerMenuList.Add(Self.AddItemInMenu(TConsts.ITEM_POPUP_MENU_PROJ_CAPTION));

  ProjectManagerMenuList.Add(Self.AddSubItemInMenu(TConsts.ITEM_POPUP_MENU_PROJ_EditInformation_CAPTION,
    FOnExecute.EditInformation));
end;

function TC4DWizardIDEPopupMenuNotifier.AddItemInMenu(const ACaption: string): IOTAProjectManagerMenu;
begin
  Result := TDelphiAIDevPopupMenuProjectsItem.New({$IF CompilerVersion = 30.0} TC4DWizardMenuContextList(nil) {$ELSE} nil {$ENDIF});
  Result.Caption := ACaption;
  Result.Verb := ACaption;
  Result.Parent := '';
  Result.Position := TUtils.IncInt(FPosition);
  Result.Checked := False;
  Result.IsMultiSelectable := False;
end;

function TC4DWizardIDEPopupMenuNotifier.AddSubItemInMenu(const ACaption: string;
  const AOnExecute: TC4DWizardMenuContextList = nil; const AChecked: Boolean = False): IOTAProjectManagerMenu;
begin
  Result := TDelphiAIDevPopupMenuProjectsItem.New(AOnExecute);
  Result.Caption := ACaption;
  Result.Verb := ACaption;
  Result.Parent := TConsts.ITEM_POPUP_MENU_PROJ_CAPTION;
  Result.Position := TUtils.IncInt(FPosition);
  Result.Checked := AChecked;
  Result.IsMultiSelectable := False;
end;

initialization

finalization
  if Index >= 0 then
    TUtilsOTA.GetIOTAProjectManager.RemoveMenuItemCreatorNotifier(Index);

end.
