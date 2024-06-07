unit DelphiCopilot.MainMenu.Register;

interface

uses
  ToolsAPI,
  System.Classes,
  System.SysUtils;

type
  TC4DWizardIDEMainMenuRegister = class(TNotifierObject, IOTAWizard)
  private
  protected
    function GetIDstring: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure Execute;
  public
    constructor Create;
    destructor Destroy; override;
  end;

procedure RegisterSelf;
procedure UnRegisterSelf;

implementation

uses
  DelphiCopilot.MainMenu,
  DelphiCopilot.Utils.OTA;

var
  C4DWizardIDEMainMenuRegister: TC4DWizardIDEMainMenuRegister;
  IndexWizard: Integer = -1;

procedure RegisterSelf;
var
  LWizard: IOTAWizard;
begin
  C4DWizardIDEMainMenuRegister := TC4DWizardIDEMainMenuRegister.Create;

  if(Supports(TObject(C4DWizardIDEMainMenuRegister), IOTAWizard, LWizard))then
    IndexWizard := TDelphiCopilotUtilsOTA.GetIOTAWizardServices.AddWizard(LWizard);
end;

procedure UnRegisterSelf;
begin
  if(IndexWizard >= 0)then
  begin
    TDelphiCopilotUtilsOTA.GetIOTAWizardServices.RemoveWizard(IndexWizard);
    IndexWizard := -1;
  end;
end;

constructor TC4DWizardIDEMainMenuRegister.Create;
begin
  TC4DWizardIDEMainMenu.GetInstance.CreateMenus;
end;

destructor TC4DWizardIDEMainMenuRegister.Destroy;
begin
  inherited;
end;

function TC4DWizardIDEMainMenuRegister.GetIDstring: string;
begin
  Result := Self.ClassName;
end;

function TC4DWizardIDEMainMenuRegister.GetName: string;
begin
  Result := Self.ClassName;
end;

function TC4DWizardIDEMainMenuRegister.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TC4DWizardIDEMainMenuRegister.Execute;
begin

end;

end.
