unit DelphiAIDev.Utils.ABMenuAction;

interface

uses
  System.SysUtils,
  System.Classes,
  VCL.Menus,
  VCL.ActnList;

type
  TABMenuAction = class(TCustomAction)
  private
    FMenuItem: TMenuItem;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property MenuItem: TMenuItem read FMenuItem write FMenuItem;
  public
    destructor Destroy; override;
    procedure ExecuteTarget(Target: TObject); override;
    function HandlesTarget(Target: TObject): Boolean; override;
  end;

function GetMenuItemOfSender(Sender: TObject): TMenuItem;

implementation

function GetMenuItemOfSender(Sender: TObject): TMenuItem;
begin
  Result := nil;
  if(Sender.ClassType.ClassName = TMenuItem.ClassName)then
    Result := TMenuItem(Sender)
  else if(Sender.ClassType.ClassName = TABMenuAction.ClassName)then
    Result := TABMenuAction(Sender).MenuItem
end;

{TABMenuAction}
destructor TABMenuAction.Destroy;
begin
  if(Assigned(FMenuItem))then
    FMenuItem.RemoveFreeNotification(Self);
  inherited;
end;

procedure TABMenuAction.ExecuteTarget(Target: TObject);
begin
  if(Assigned(FMenuItem))then
    FMenuItem.Click;
end;

function TABMenuAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := True;
end;

procedure TABMenuAction.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if(Operation = opRemove) and (AComponent = FMenuItem)then
    FMenuItem := nil;
end;

end.
