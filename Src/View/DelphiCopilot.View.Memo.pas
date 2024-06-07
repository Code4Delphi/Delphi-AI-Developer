unit DelphiCopilot.View.Memo;

interface

uses
  System.Classes,
  System.SysUtils,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.StdCtrls,
  Winapi.Windows;

type
  TDelphiCopilotViewMemo = class(TForm)
    pnMemo: TPanel;
    pnButtons: TPanel;
    btnOK: TButton;
    mmMensagem: TMemo;
    procedure btnOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure mmMensagemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
  protected

  public

  end;

implementation

uses
  DelphiCopilot.Utils.OTA;

{$R *.dfm}


procedure TDelphiCopilotViewMemo.FormCreate(Sender: TObject);
begin
  TDelphiCopilotUtilsOTA.IDEThemingAll(TDelphiCopilotViewMemo, Self);
end;

procedure TDelphiCopilotViewMemo.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case(Key)of
    VK_F4:
    if(ssAlt in Shift)then
      Key := 0;
    VK_ESCAPE:
    if(Shift = [])then
      btnOK.Click;
  end;
end;

procedure TDelphiCopilotViewMemo.mmMensagemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if(Key = $41)and(Shift = [ssCtrl])then
    mmMensagem.SelectAll;
end;

procedure TDelphiCopilotViewMemo.btnOKClick(Sender: TObject);
begin
  Self.Close;
end;

end.
