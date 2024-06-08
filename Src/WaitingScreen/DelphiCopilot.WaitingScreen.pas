unit DelphiCopilot.WaitingScreen;

interface

uses
  System.SysUtils,
  DelphiCopilot.WaitingScreen.View;

type
  TDelphiCopilotWaitingScreen = class
  private
    FC4DWizardViewWaitingScreen: TDelphiCopilotWaitingScreenView;
    constructor Create;
  public
    destructor Destroy; override;
    class function GetInstance: TDelphiCopilotWaitingScreen;
    procedure Show(const AMsg: string = '');
    procedure Close;
  end;

implementation

var
  Instance: TDelphiCopilotWaitingScreen;

class function TDelphiCopilotWaitingScreen.GetInstance: TDelphiCopilotWaitingScreen;
begin
  if(not Assigned(Instance))then
    Instance := Self.Create;
  Result := Instance;
end;

constructor TDelphiCopilotWaitingScreen.Create;
begin

end;

destructor TDelphiCopilotWaitingScreen.Destroy;
begin
  inherited;
end;

procedure TDelphiCopilotWaitingScreen.Show(const AMsg: string = '');
begin
  if(not Assigned(FC4DWizardViewWaitingScreen))then
    FC4DWizardViewWaitingScreen := TDelphiCopilotWaitingScreenView.Create(nil);
  FC4DWizardViewWaitingScreen.Msg := AMsg;
  FC4DWizardViewWaitingScreen.Show;
end;

procedure TDelphiCopilotWaitingScreen.Close;
begin
  FC4DWizardViewWaitingScreen.Close;
  FreeAndNil(FC4DWizardViewWaitingScreen);
end;

initialization

finalization
  if(Assigned(Instance))then
    FreeAndNil(Instance);

end.
