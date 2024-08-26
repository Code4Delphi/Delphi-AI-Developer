unit DelphiAIDev.PopupMenuProjects.OnExecute;

interface

uses
  System.SysUtils,
  System.Classes,
  ToolsAPI;

type
  TDelphiAIDevPopupMenuProjectsOnExecute = class
  private
    FIOTAProject: IOTAProject;
    procedure CheckFileNameProject;
  public
    procedure LinkDatabase(const MenuContextList: IInterfaceList);
    property OTAProject: IOTAProject write FIOTAProject;
  end;

implementation

uses
  DelphiAIDev.Utils,
  DelphiAIDev.Projects.AddEdit.View;

procedure TDelphiAIDevPopupMenuProjectsOnExecute.CheckFileNameProject;
begin
  if FIOTAProject.FileName.Trim.IsEmpty then
    TUtils.ShowMsgAndAbort('Project file name is empty');

//  if not System.SysUtils.FileExists(FIOTAProject.FileName) then
//    TUtils.ShowMsgAndAbort('Project file not found');
end;

procedure TDelphiAIDevPopupMenuProjectsOnExecute.LinkDatabase(const MenuContextList: IInterfaceList);
var
  LView: TDelphiAIDevProjectsAddEditView;
begin
  Self.CheckFileNameProject;

  LView := TDelphiAIDevProjectsAddEditView.Create(nil);
  try
    LView.OTAProject := FIOTAProject;
    LView.ShowModal;
  finally
    LView.Free;
  end;
end;

end.
