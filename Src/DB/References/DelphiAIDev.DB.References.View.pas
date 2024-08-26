unit DelphiAIDev.DB.References.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  DelphiAIDev.Types,
  DelphiAIDev.DB.Registers.Fields,
  DelphiAIDev.MetaInfo;

type
  TDelphiAIDevDBReferencesView = class(TForm)
    Bevel2: TBevel;
    pnButtons: TPanel;
    btnGenerate: TButton;
    btnClose: TButton;
    pnBody: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    lbLastGeneration: TLabel;
    ckAddFieldSize: TCheckBox;
    ckCompressData: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnGenerateClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FFields: TDelphiAIDevDBRegistersFields;
    procedure FillScreenFields;
  public
    property Fields: TDelphiAIDevDBRegistersFields read FFields write FFields;
  end;

implementation

uses
  DelphiAIDev.Consts,
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA;

{$R *.dfm}

procedure TDelphiAIDevDBReferencesView.FormCreate(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
  TUtilsOTA.IDEThemingAll(TDelphiAIDevDBReferencesView, Self);
end;

procedure TDelphiAIDevDBReferencesView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F4:
      if ssAlt in Shift then
        Key := 0;
    VK_ESCAPE:
      if Shift = [] then
        btnClose.Click;
  end;
end;

procedure TDelphiAIDevDBReferencesView.FormShow(Sender: TObject);
begin
  Self.FillScreenFields;
end;

procedure TDelphiAIDevDBReferencesView.FillScreenFields;
begin
  lbLastGeneration.Caption := 'Never';
  if FFields.LastReferences > 0 then
    lbLastGeneration.Caption := DateTimeToStr(FFields.LastReferences);
end;

procedure TDelphiAIDevDBReferencesView.btnGenerateClick(Sender: TObject);
var
  LMetaInfo: TDelphiAIDevMetaInfo;
begin
  Screen.Cursor := crHourGlass;
  try
    LMetaInfo := TDelphiAIDevMetaInfo.Create(FFields);
    try
      LMetaInfo.AddFieldLength := ckAddFieldSize.Checked;
      LMetaInfo.CompressData := ckCompressData.Checked;
      LMetaInfo.Process;
    finally
      LMetaInfo.Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end;

  Self.Close;
  Self.ModalResult := mrOk;
end;

procedure TDelphiAIDevDBReferencesView.btnCloseClick(Sender: TObject);
begin
  Self.Close;
  Self.ModalResult := mrCancel;
end;

end.

