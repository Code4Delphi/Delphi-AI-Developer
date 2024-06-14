unit DelphiCopilot.ModuleCreator;

interface

uses
  System.SysUtils,
  System.Classes,
  ToolsAPI,
  DelphiCopilot.ModuleCreator.Interfaces,
  DelphiCopilot.ModuleCreator.OTA,
  DelphiCopilot.Utils,
  DelphiCopilot.Utils.OTA;

type
  IDelphiCopilotModuleCreator = DelphiCopilot.ModuleCreator.Interfaces.IDelphiCopilotModuleCreator;

  TDelphiCopilotModuleCreator = class(TInterfacedObject, IDelphiCopilotModuleCreator)
  private
  protected
    procedure CreateNewUnit(const AContentUnit: string);
  public
    class function New: IDelphiCopilotModuleCreator;
  end;

implementation

class function TDelphiCopilotModuleCreator.New: IDelphiCopilotModuleCreator;
begin
  Result := Self.Create;
end;

procedure TDelphiCopilotModuleCreator.CreateNewUnit(const AContentUnit: string);
var
  LIOTAModuleServices: IOTAModuleServices;
  LCodeUnit: TStrings;
begin
  LCodeUnit := TStringList.Create;
  try
    LCodeUnit.Text := AContentUnit.Trim;

    if not(LCodeUnit[0].Contains('unit '))then
    begin
      LCodeUnit.Clear;
      LCodeUnit.Add('unit NewUnit;' + sLineBreak);
      LCodeUnit.Add('interface' + sLineBreak);

      if not(AContentUnit.Contains('implementation')) then
        LCodeUnit.Add('implementation' + sLineBreak);

      LCodeUnit.Add(AContentUnit.Trim);
    end;

    if not(LCodeUnit[Pred(LCodeUnit.Count)].Trim.Equals('end.'))then
      LCodeUnit.Add(sLineBreak + 'end.');

    LIOTAModuleServices := TUtilsOTA.GetIOTAModuleServices;
    LIOTAModuleServices.CreateModule(TDelphiCopilotModuleCreatorOTA.Create(LCodeUnit.Text));
  finally
    LCodeUnit.Free;
  end;
end;

end.
