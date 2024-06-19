unit DelphiAIDev.View.About;

interface

uses
  System.Classes,
  System.SysUtils,
  ToolsAPI,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Imaging.pngimage,
  Vcl.StdCtrls,
  Vcl.Dialogs,
  Winapi.Windows,
  DelphiAIDev.Consts,
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA;

type
  TDelphiAIDevViewAbout = class(TForm)
    pnBody: TPanel;
    Bevel1: TBevel;
    mmMensagem: TMemo;
    Panel2: TPanel;
    pnBackSite: TPanel;
    lbSiteCode4Delphi: TLabel;
    imgLogoC4D: TImage;
    pnBackGithub: TPanel;
    lbGitHubCode4Delphi: TLabel;
    imgGithub: TImage;
    pnButtons: TPanel;
    btnOK: TButton;
    btnTeste: TButton;
    Panel1: TPanel;
    lbDonateToCode4Delphi: TLabel;
    imgDonate: TImage;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lbSiteCode4DelphiClick(Sender: TObject);
    procedure lbSiteCode4DelphiMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure lbSiteCode4DelphiMouseLeave(Sender: TObject);
    procedure lbGitHubCode4DelphiClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnTesteClick(Sender: TObject);
    procedure lbDonateToCode4DelphiClick(Sender: TObject);
  private

  public

  end;

var
  DelphiAIDevViewAbout: TDelphiAIDevViewAbout;

implementation

{$R *.dfm}


procedure TDelphiAIDevViewAbout.FormCreate(Sender: TObject);
begin
  TUtilsOTA.IDEThemingAll(TDelphiAIDevViewAbout, Self);
end;

procedure TDelphiAIDevViewAbout.FormShow(Sender: TObject);
begin
  Self.Caption := TConsts.MENU_IDE_ABOUT_CAPTION + TConsts.SEMANTIC_VERSION;

  mmMensagem.Lines.Clear;
  mmMensagem.Lines.Add(TConsts.ABOUT_COPY_RIGHT);
  mmMensagem.Lines.Add(TConsts.ABOUT_DESCRIPTION);
  mmMensagem.Lines.Add(TConsts.SEMANTIC_VERSION_LB);
  mmMensagem.Lines.Add(TConsts.PLUGIN_LICENSE);
end;

procedure TDelphiAIDevViewAbout.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TDelphiAIDevViewAbout.btnOKClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TDelphiAIDevViewAbout.lbSiteCode4DelphiClick(Sender: TObject);
begin
  TUtils.OpenLink('http://www.code4delphi.com.br');
end;

procedure TDelphiAIDevViewAbout.lbGitHubCode4DelphiClick(Sender: TObject);
begin
  TUtils.OpenLink('https://github.com/code4delphi');
end;

procedure TDelphiAIDevViewAbout.lbDonateToCode4DelphiClick(Sender: TObject);
begin
  TUtils.OpenLink('https://pag.ae/7ZhEY1xKr');
end;

procedure TDelphiAIDevViewAbout.lbSiteCode4DelphiMouseLeave(Sender: TObject);
begin
  //*SEVERAL
  TLabel(Sender).Font.Color := TUtilsOTA.ActiveThemeColorDefault;
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style - [fsUnderline];
end;

procedure TDelphiAIDevViewAbout.lbSiteCode4DelphiMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  //*SEVERAL
  TLabel(Sender).Font.Color := clRed;
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style + [fsUnderline];
end;

procedure TDelphiAIDevViewAbout.btnTesteClick(Sender: TObject);
begin
  //
end;

end.
