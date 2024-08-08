unit DelphiAIDev.PopupMenuProjects;

interface

uses
  System.SysUtils,
  System.Classes,
  ToolsAPI,
  DelphiAIDev.Types,
 DelphiAIDev.PopupMenuProjects.Item;

type
  TC4DWizardIDEPopupMenuNotifier = class(TNotifierObject, IOTAProjectMenuItemCreatorNotifier)
  private
    FProject: IOTAProject;
    FPosition: Integer;
    function AddItemInMenu(const ACaption: string): IOTAProjectManagerMenu;
    function AddSubItemInMenu(const ACaption: string;
      const AOnExecute: TC4DWizardMenuContextList = nil;
      const AChecked: Boolean = False): IOTAProjectManagerMenu;
    procedure CheckFileNameProject;
    //function GetReopenDataOfFileName: TC4DWizardReopenData;
    procedure OnExecuteEditInformations(const MenuContextList: IInterfaceList);
  protected
    procedure AddMenu(const Project: IOTAProject; const IdentList: TStrings; const ProjectManagerMenuList: IInterfaceList; IsMultiSelect: Boolean);
  public
    class function New: IOTAProjectMenuItemCreatorNotifier;
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

procedure TC4DWizardIDEPopupMenuNotifier.AddMenu(const Project: IOTAProject; const IdentList: TStrings; const ProjectManagerMenuList: IInterfaceList; IsMultiSelect: Boolean);
begin
  if(not Assigned(ProjectManagerMenuList))then
    Exit;

  if(IdentList.IndexOf(sProjectContainer) >= 0)then
    FPosition := pmmpUninstall
  else if(IdentList.IndexOf(sProjectGroupContainer) >= 0)then
    FPosition := pmmpRename
  else
    Exit;

  FProject := Project;
  FPosition := FPosition + 201;
  ProjectManagerMenuList.Add(Self.AddItemInMenu('-'));
  ProjectManagerMenuList.Add(Self.AddItemInMenu(TConsts.ITEM_POPUP_MENU_PROJ_CAPTION));

  ProjectManagerMenuList.Add(Self.AddSubItemInMenu(TConsts.ITEM_POPUP_MENU_PROJ_ConfigureDB_CAPTION,
    OnExecuteEditInformations));
end;

procedure TC4DWizardIDEPopupMenuNotifier.OnExecuteEditInformations(const MenuContextList: IInterfaceList);
begin
  Self.CheckFileNameProject;
  //TC4DWizardReopenController.New(FProject.FileName).EditInformations;
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
  const AOnExecute: TC4DWizardMenuContextList = nil;
  const AChecked: Boolean = False): IOTAProjectManagerMenu;
begin
  Result := TDelphiAIDevPopupMenuProjectsItem.New(AOnExecute);
  Result.Caption := ACaption;
  Result.Verb := ACaption;
  Result.Parent := TConsts.ITEM_POPUP_MENU_PROJ_CAPTION;
  Result.Position := TUtils.IncInt(FPosition);
  Result.Checked := AChecked;
  Result.IsMultiSelectable := False;
end;

procedure TC4DWizardIDEPopupMenuNotifier.CheckFileNameProject;
begin
  if(FProject.FileName.Trim.IsEmpty)then
    TUtils.ShowMsgAndAbort('File name is empty');

  if(not System.SysUtils.FileExists(FProject.FileName))then
    TUtils.ShowMsgAndAbort('File not found');
end;

initialization

finalization
  if Index >= 0 then
    TUtilsOTA.GetIOTAProjectManager.RemoveMenuItemCreatorNotifier(Index);

end.
