unit DelphiCopilot.MainMenu.Register;

interface

uses
  ToolsAPI,
  System.Classes,
  System.SysUtils;

type
  TDelphiCopilotIDEMainMenuRegister = class(TNotifierObject, IOTAWizard)
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
  C4DWizardIDEMainMenuRegister: TDelphiCopilotIDEMainMenuRegister;
  IndexWizard: Integer = -1;

procedure RegisterSelf;
var
  LWizard: IOTAWizard;
begin
  C4DWizardIDEMainMenuRegister := TDelphiCopilotIDEMainMenuRegister.Create;

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

constructor TDelphiCopilotIDEMainMenuRegister.Create;
begin
  TDelphiCopilotIDEMainMenu.GetInstance.CreateMenus;
end;

destructor TDelphiCopilotIDEMainMenuRegister.Destroy;
begin
  inherited;
end;

function TDelphiCopilotIDEMainMenuRegister.GetIDstring: string;
begin
  Result := Self.ClassName;
end;

function TDelphiCopilotIDEMainMenuRegister.GetName: string;
begin
  Result := Self.ClassName;
end;

function TDelphiCopilotIDEMainMenuRegister.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TDelphiCopilotIDEMainMenuRegister.Execute;
begin

end;

end.
