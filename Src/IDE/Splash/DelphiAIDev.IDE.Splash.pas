unit DelphiAIDev.IDE.Splash;

interface

implementation

uses
  Windows,
  SysUtils,
  ToolsAPI,
  DesignIntf,
  DelphiAIDev.Consts;

procedure RegisterSplashScreen;
begin
  ForceDemandLoadState(dlDisable);
  SplashScreenServices.AddPluginBitmap(TConsts.ABOUT_TITLE, LoadBitmap(HInstance, TConsts.RESOURCE_c4d_logo_24x24),
    TConsts.IS_UNREGISTERED, TConsts.PLUGIN_LICENSE);
end;

initialization
  RegisterSplashScreen;

finalization

end.
