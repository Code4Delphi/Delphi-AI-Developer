unit DelphiAIDev.WaitingScreen;

interface

uses
  System.SysUtils,
  DelphiAIDev.WaitingScreen.View;

type
  TDelphiAIDevWaitingScreen = class
  private
    FDelphiAIDevWaitingScreenView: TDelphiAIDevWaitingScreenView;
    constructor Create;
  public
    destructor Destroy; override;
    class function GetInstance: TDelphiAIDevWaitingScreen;
    procedure Show(const AMsg: string = '');
    procedure Close;
  end;

implementation

var
  Instance: TDelphiAIDevWaitingScreen;

class function TDelphiAIDevWaitingScreen.GetInstance: TDelphiAIDevWaitingScreen;
begin
  if(not Assigned(Instance))then
    Instance := Self.Create;
  Result := Instance;
end;

constructor TDelphiAIDevWaitingScreen.Create;
begin

end;

destructor TDelphiAIDevWaitingScreen.Destroy;
begin
  inherited;
end;

procedure TDelphiAIDevWaitingScreen.Show(const AMsg: string = '');
begin
  if(not Assigned(FDelphiAIDevWaitingScreenView))then
    FDelphiAIDevWaitingScreenView := TDelphiAIDevWaitingScreenView.Create(nil);
  FDelphiAIDevWaitingScreenView.Msg := AMsg;
  FDelphiAIDevWaitingScreenView.Show;
end;

procedure TDelphiAIDevWaitingScreen.Close;
begin
  FDelphiAIDevWaitingScreenView.Close;
  FreeAndNil(FDelphiAIDevWaitingScreenView);
end;

initialization

finalization
  if(Assigned(Instance))then
    FreeAndNil(Instance);

end.
