unit DelphiCopilot.IDE.ImageListMain;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TDelphiCopilotIDEImageListMain = class
  private
    FImgIndexC4D_Logo: Integer;
    FImgIndexGear: Integer;
    FImgIndexMessage: Integer;
    constructor Create;
  public
    property ImgIndexC4D_Logo: Integer read FImgIndexC4D_Logo;
    property ImgIndexGear: Integer read FImgIndexGear;
    property ImgIndexMessage: Integer read FImgIndexMessage;
    class function GetInstance: TDelphiCopilotIDEImageListMain;
  end;

implementation

uses
  DelphiCopilot.Utils.OTA;

var
  Instance: TDelphiCopilotIDEImageListMain;

class function TDelphiCopilotIDEImageListMain.GetInstance: TDelphiCopilotIDEImageListMain;
begin
  if(not Assigned(Instance))then
    Instance := Self.Create;
  Result := Instance;
end;

constructor TDelphiCopilotIDEImageListMain.Create;
begin
  FImgIndexC4D_Logo := TUtilsOTA.AddImgIDEResourceName('c4d_logo');
  FImgIndexGear := TUtilsOTA.AddImgIDEResourceName('c4d_gear');
  FImgIndexMessage := TUtilsOTA.AddImgIDEResourceName('c4d_message');
end;

initialization
  Instance := TDelphiCopilotIDEImageListMain.GetInstance;

finalization
  if(Assigned(Instance))then
    Instance.Free;

end.
