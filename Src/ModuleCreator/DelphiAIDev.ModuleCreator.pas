unit DelphiAIDev.ModuleCreator;

interface

uses
  System.SysUtils,
  System.Classes,
  ToolsAPI,
  DelphiAIDev.ModuleCreator.Interfaces,
  DelphiAIDev.ModuleCreator.OTA,
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA;

type
  IDelphiAIDevModuleCreator = DelphiAIDev.ModuleCreator.Interfaces.IDelphiAIDevModuleCreator;

  TDelphiAIDevModuleCreator = class(TInterfacedObject, IDelphiAIDevModuleCreator)
  private
  protected
    procedure CreateNewUnit(const AContentUnit: string);
  public
    class function New: IDelphiAIDevModuleCreator;
  end;

implementation

class function TDelphiAIDevModuleCreator.New: IDelphiAIDevModuleCreator;
begin
  Result := Self.Create;
end;

procedure TDelphiAIDevModuleCreator.CreateNewUnit(const AContentUnit: string);
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
    LIOTAModuleServices.CreateModule(TDelphiAIDevModuleCreatorOTA.Create(LCodeUnit.Text));
  finally
    LCodeUnit.Free;
  end;
end;

end.
