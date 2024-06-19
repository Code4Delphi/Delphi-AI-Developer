unit DelphiAIDev.View.Memo;

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
  TDelphiAIDevViewMemo = class(TForm)
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
  DelphiAIDev.Utils.OTA;

{$R *.dfm}

procedure TDelphiAIDevViewMemo.FormCreate(Sender: TObject);
begin
  TUtilsOTA.IDEThemingAll(TDelphiAIDevViewMemo, Self);
end;

procedure TDelphiAIDevViewMemo.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TDelphiAIDevViewMemo.mmMensagemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
const
  KEY_A = $41;
begin
  if(Key = KEY_A)and(Shift = [ssCtrl])then
    mmMensagem.SelectAll;
end;

procedure TDelphiAIDevViewMemo.btnOKClick(Sender: TObject);
begin
  Self.Close;
end;

end.
