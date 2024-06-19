unit DelphiAIDev.MainMenu.Register;

interface

uses
  ToolsAPI,
  System.Classes,
  System.SysUtils;

type
  TDelphiAIDevIDEMainMenuRegister = class(TNotifierObject, IOTAWizard)
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
  DelphiAIDev.MainMenu,
  DelphiAIDev.Utils.OTA;

var
  DelphiAIDevIDEMainMenuRegister: TDelphiAIDevIDEMainMenuRegister;
  IndexPlugin: Integer = -1;

procedure RegisterSelf;
var
  LIOTAWizard: IOTAWizard;
begin
  DelphiAIDevIDEMainMenuRegister := TDelphiAIDevIDEMainMenuRegister.Create;

  if(Supports(TObject(DelphiAIDevIDEMainMenuRegister), IOTAWizard, LIOTAWizard))then
    IndexPlugin := TUtilsOTA.GetIOTAWizardServices.AddWizard(LIOTAWizard);
end;

procedure UnRegisterSelf;
begin
  if IndexPlugin >= 0 then
  begin
    TUtilsOTA.GetIOTAWizardServices.RemoveWizard(IndexPlugin);
    IndexPlugin := -1;
  end;
end;

constructor TDelphiAIDevIDEMainMenuRegister.Create;
begin
  TDelphiAIDevIDEMainMenu.GetInstance.CreateMenus;
end;

destructor TDelphiAIDevIDEMainMenuRegister.Destroy;
begin
  inherited;
end;

function TDelphiAIDevIDEMainMenuRegister.GetIDstring: string;
begin
  Result := Self.ClassName;
end;

function TDelphiAIDevIDEMainMenuRegister.GetName: string;
begin
  Result := Self.ClassName;
end;

function TDelphiAIDevIDEMainMenuRegister.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TDelphiAIDevIDEMainMenuRegister.Execute;
begin

end;

end.
