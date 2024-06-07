unit DelphiCopilot.WaitingScreen;

interface

uses
  System.SysUtils,
  DelphiCopilot.WaitingScreen.View;

type
  TC4DWizardWaitingScreen = class
  private
    FC4DWizardViewWaitingScreen: TDelphiCopilotWaitingScreenView;
    constructor Create;
  public
    destructor Destroy; override;
    class function GetInstance: TC4DWizardWaitingScreen;
    procedure Show(const AMsg: string = '');
    procedure Close;
  end;

implementation

var
  Instance: TC4DWizardWaitingScreen;

class function TC4DWizardWaitingScreen.GetInstance: TC4DWizardWaitingScreen;
begin
  if(not Assigned(Instance))then
    Instance := Self.Create;
  Result := Instance;
end;

constructor TC4DWizardWaitingScreen.Create;
begin

end;

destructor TC4DWizardWaitingScreen.Destroy;
begin
  inherited;
end;

procedure TC4DWizardWaitingScreen.Show(const AMsg: string = '');
begin
  if(not Assigned(FC4DWizardViewWaitingScreen))then
    FC4DWizardViewWaitingScreen := TDelphiCopilotWaitingScreenView.Create(nil);
  FC4DWizardViewWaitingScreen.Msg := AMsg;
  FC4DWizardViewWaitingScreen.Show;
end;

procedure TC4DWizardWaitingScreen.Close;
begin
  FC4DWizardViewWaitingScreen.Close;
  FreeAndNil(FC4DWizardViewWaitingScreen);
end;

initialization

finalization
  if(Assigned(Instance))then
    FreeAndNil(Instance);

end.
