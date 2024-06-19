unit DelphiAIDev.ModuleCreator.OTA;

interface

uses
  System.SysUtils,
  System.Classes,
  ToolsAPI;

type
  TDelphiAIDevModuleCreatorOTA = class(TInterfacedobject, IOTACreator, IOTAModuleCreator)
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

constructor TDelphiAIDevModuleCreatorOTA.Create(const AContentUnit: string);
begin
  FContentUnit := AContentUnit.TrimRight;
end;

function TDelphiAIDevModuleCreatorOTA.GetCreatorType: string;
begin
  Result := sApplication;
end;

function TDelphiAIDevModuleCreatorOTA.GetExisting: Boolean;
begin
  Result := False;
end;

function TDelphiAIDevModuleCreatorOTA.GetFileSystem: string;
begin
  Result := '';
end;

function TDelphiAIDevModuleCreatorOTA.GetOwner: IOTAModule;
begin
  Result := GetActiveProject; // (BorlandIDEServices as IOTAModuleServices).MainProjectGroup;
end;

function TDelphiAIDevModuleCreatorOTA.GetUnnamed: Boolean;
begin
  Result := True;
end;

{IOTAModuleCreator}
function TDelphiAIDevModuleCreatorOTA.GetAncestorName: string;
begin
  Result := '';
end;

function TDelphiAIDevModuleCreatorOTA.GetImplFileName: string;
begin
  Result := '';
end;

function TDelphiAIDevModuleCreatorOTA.GetIntfFileName: string;
begin
  Result := '';
end;

function TDelphiAIDevModuleCreatorOTA.GetFormName: string;
begin
  Result := '';
end;

function TDelphiAIDevModuleCreatorOTA.GetMainForm: Boolean;
begin
  Result := False;
end;

function TDelphiAIDevModuleCreatorOTA.GetShowForm: Boolean;
begin
  Result := False;
end;

function TDelphiAIDevModuleCreatorOTA.GetShowSource: Boolean;
begin
  Result := True;
end;

function TDelphiAIDevModuleCreatorOTA.NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
begin
end;

function TDelphiAIDevModuleCreatorOTA.NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := TOTAFile.Create(FContentUnit);
end;

function TDelphiAIDevModuleCreatorOTA.NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
begin
end;

procedure TDelphiAIDevModuleCreatorOTA.FormCreated(const FormEditor: IOTAFormEditor);
begin
end;

end.
