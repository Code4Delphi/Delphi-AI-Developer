unit DelphiAIDev.PopupMenuProjects.Item;

interface

uses
  System.SysUtils,
  System.Classes,
  ToolsAPI,
  DelphiAIDev.Types;

type
  TDelphiAIDevPopupMenuProjectsItem = class(TNotifierObject, IOTALocalMenu, IOTAProjectManagerMenu)
  private
    FCaption: string;
    FIsMultiSelectable: Boolean;
    FChecked: Boolean;
    FEnabled: Boolean;
    FHelpContext: Integer;
    FName: string;
    FParent: string;
    FPosition: Integer;
    FVerb: string;
  protected
    FProject: IOTAProject;
    FOnExecute: TC4DWizardMenuContextList;
    function GetCaption: string;
    function GetChecked: Boolean;
    function GetEnabled: Boolean;
    function GetHelpContext: Integer;
    function GetName: string;
    function GetParent: string;
    function GetPosition: Integer;
    function GetVerb: string;
    procedure SetCaption(const Value: string);
    procedure SetChecked(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetHelpContext(Value: Integer);
    procedure SetName(const Value: string);
    procedure SetParent(const Value: string);
    procedure SetPosition(Value: Integer);
    procedure SetVerb(const Value: string);
    function GetIsMultiSelectable: Boolean;
    procedure SetIsMultiSelectable(Value: Boolean);
    procedure Execute(const MenuContextList: IInterfaceList); virtual;
    function PreExecute(const MenuContextList: IInterfaceList): Boolean;
    function PostExecute(const MenuContextList: IInterfaceList): Boolean;
  public
    class function New(OnExecute: TC4DWizardMenuContextList): IOTAProjectManagerMenu; overload;
    constructor Create(OnExecute: TC4DWizardMenuContextList); overload;
  end;

implementation

class function TDelphiAIDevPopupMenuProjectsItem.New(OnExecute: TC4DWizardMenuContextList): IOTAProjectManagerMenu;
begin
  Result := Self.Create(OnExecute);
end;

constructor TDelphiAIDevPopupMenuProjectsItem.Create(OnExecute: TC4DWizardMenuContextList);
begin
  FOnExecute := OnExecute;
  FEnabled := True;
  FChecked := False;
  FIsMultiSelectable := False;
end;

procedure TDelphiAIDevPopupMenuProjectsItem.Execute(const MenuContextList: IInterfaceList);
begin
  if Assigned(FOnExecute) then
    FOnExecute(MenuContextList);
end;

function TDelphiAIDevPopupMenuProjectsItem.GetCaption: string;
begin
  Result := FCaption;
end;

function TDelphiAIDevPopupMenuProjectsItem.GetChecked: Boolean;
begin
  Result := FChecked;
end;

function TDelphiAIDevPopupMenuProjectsItem.GetEnabled: Boolean;
begin
  Result := FEnabled;
end;

function TDelphiAIDevPopupMenuProjectsItem.GetHelpContext: Integer;
begin
  Result := FHelpContext;
end;

function TDelphiAIDevPopupMenuProjectsItem.GetIsMultiSelectable: Boolean;
begin
  Result := FIsMultiSelectable;
end;

function TDelphiAIDevPopupMenuProjectsItem.GetName: string;
begin
  Result := FName;
end;

function TDelphiAIDevPopupMenuProjectsItem.GetParent: string;
begin
  Result := FParent;
end;

function TDelphiAIDevPopupMenuProjectsItem.GetPosition: Integer;
begin
  Result := FPosition;
end;

function TDelphiAIDevPopupMenuProjectsItem.GetVerb: string;
begin
  Result := FVerb;
end;

function TDelphiAIDevPopupMenuProjectsItem.PostExecute(const MenuContextList: IInterfaceList): Boolean;
begin
  Result := True;
end;

function TDelphiAIDevPopupMenuProjectsItem.PreExecute(const MenuContextList: IInterfaceList): Boolean;
begin
  Result := True;
end;

procedure TDelphiAIDevPopupMenuProjectsItem.SetCaption(const Value: string);
begin
  FCaption := Value;
end;

procedure TDelphiAIDevPopupMenuProjectsItem.SetChecked(Value: Boolean);
begin
  FChecked := Value;
end;

procedure TDelphiAIDevPopupMenuProjectsItem.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
end;

procedure TDelphiAIDevPopupMenuProjectsItem.SetHelpContext(Value: Integer);
begin
  FHelpContext := Value;
end;

procedure TDelphiAIDevPopupMenuProjectsItem.SetIsMultiSelectable(Value: Boolean);
begin
  FIsMultiSelectable := Value;
end;

procedure TDelphiAIDevPopupMenuProjectsItem.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TDelphiAIDevPopupMenuProjectsItem.SetParent(const Value: string);
begin
  FParent := Value;
end;

procedure TDelphiAIDevPopupMenuProjectsItem.SetPosition(Value: Integer);
begin
  FPosition := Value;
end;

procedure TDelphiAIDevPopupMenuProjectsItem.SetVerb(const Value: string);
begin
  FVerb := Value;
end;

end.
