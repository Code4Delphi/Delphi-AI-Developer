unit DelphiAIDev.WaitingScreen.View;

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
  TDelphiAIDevWaitingScreenView = class(TForm)
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
  DelphiAIDev.Utils.OTA;

{$R *.dfm}


const
  C_MSG_DEFAULT = 'Wait for loading...';

procedure TDelphiAIDevWaitingScreenView.FormCreate(Sender: TObject);
begin
  TUtilsOTA.IDEThemingAll(TDelphiAIDevWaitingScreenView, Self);
  FMsg := '';
end;

procedure TDelphiAIDevWaitingScreenView.FormShow(Sender: TObject);
begin
  lbMsg.Caption := C_MSG_DEFAULT;
  if(not FMsg.Trim.IsEmpty)then
    lbMsg.Caption := FMsg;

  Self.BringToFront;
end;

procedure TDelphiAIDevWaitingScreenView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if(Key = VK_F4)and(ssAlt in Shift)then
    Key := 0;
end;

end.
