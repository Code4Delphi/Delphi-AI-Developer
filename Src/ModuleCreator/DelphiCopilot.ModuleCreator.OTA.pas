unit DelphiCopilot.ModuleCreator.OTA;

interface

uses
  System.SysUtils,
  System.Classes,
  ToolsAPI;

type
  TDelphiCopilotModuleCreatorOTA = class(TInterfacedobject, IOTACreator, IOTAModuleCreator)
  private
    FContentUnit: string;
  public
    //IOTACreator
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;

    //IOTAModuleCreator
    function GetAncestorName: string;
    function GetImplFileName: string;
    function GetIntfFileName: string;
    function GetFormName: string;
    function GetMainForm: Boolean;
    function GetShowForm: Boolean;
    function GetShowSource: Boolean;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    procedure FormCreated(const FormEditor: IOTAFormEditor);

    constructor Create(const AContentUnit: string);
  end;

implementation

constructor TDelphiCopilotModuleCreatorOTA.Create(const AContentUnit: string);
begin
  FContentUnit := AContentUnit.TrimRight;
end;

function TDelphiCopilotModuleCreatorOTA.GetCreatorType: string;
begin
  Result := sApplication;
end;

function TDelphiCopilotModuleCreatorOTA.GetExisting: Boolean;
begin
  Result := False;
end;

function TDelphiCopilotModuleCreatorOTA.GetFileSystem: string;
begin
  Result := '';
end;

function TDelphiCopilotModuleCreatorOTA.GetOwner: IOTAModule;
begin
  Result := GetActiveProject; // (BorlandIDEServices as IOTAModuleServices).MainProjectGroup;
end;

function TDelphiCopilotModuleCreatorOTA.GetUnnamed: Boolean;
begin
  Result := True;
end;

{IOTAModuleCreator}
function TDelphiCopilotModuleCreatorOTA.GetAncestorName: string;
begin
  Result := '';
end;

function TDelphiCopilotModuleCreatorOTA.GetImplFileName: string;
begin
  Result := '';
end;

function TDelphiCopilotModuleCreatorOTA.GetIntfFileName: string;
begin
  Result := '';
end;

function TDelphiCopilotModuleCreatorOTA.GetFormName: string;
begin
  Result := '';
end;

function TDelphiCopilotModuleCreatorOTA.GetMainForm: Boolean;
begin
  Result := False;
end;

function TDelphiCopilotModuleCreatorOTA.GetShowForm: Boolean;
begin
  Result := False;
end;

function TDelphiCopilotModuleCreatorOTA.GetShowSource: Boolean;
begin
  Result := True;
end;

function TDelphiCopilotModuleCreatorOTA.NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
begin
end;

function TDelphiCopilotModuleCreatorOTA.NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := TOTAFile.Create(FContentUnit);
end;

function TDelphiCopilotModuleCreatorOTA.NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
begin
end;

procedure TDelphiCopilotModuleCreatorOTA.FormCreated(const FormEditor: IOTAFormEditor);
begin
end;

end.
