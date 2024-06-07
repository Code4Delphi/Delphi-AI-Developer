unit DelphiCopilot.WaitingScreen.View;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Classes,
  Winapi.Windows,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TDelphiCopilotWaitingScreenView = class(TForm)
    pnBody: TPanel;
    lbMsg: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FMsg: string;
  public
    property Msg: string read FMsg write FMsg;
  end;

implementation

uses
  DelphiCopilot.Utils.OTA;

{$R *.dfm}


const
  C_MSG_DEFAULT = 'Wait for loading...';

procedure TDelphiCopilotWaitingScreenView.FormCreate(Sender: TObject);
begin
  TDelphiCopilotUtilsOTA.IDEThemingAll(TDelphiCopilotWaitingScreenView, Self);
  FMsg := '';
end;

procedure TDelphiCopilotWaitingScreenView.FormShow(Sender: TObject);
begin
  lbMsg.Caption := C_MSG_DEFAULT;
  if(not FMsg.Trim.IsEmpty)then
    lbMsg.Caption := FMsg;

  Self.BringToFront;
end;

procedure TDelphiCopilotWaitingScreenView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if(Key = VK_F4)and(ssAlt in Shift)then
    Key := 0;
end;

end.
