unit DelphiAIDev.DB.Utils;

interface

uses
  System.SysUtils,
  Vcl.StdCtrls;

type
  TDelphiAIDevDBUtils = class
  private
  public
    class procedure ClearComboBox(const AComboBox: TComboBox);
    class procedure FillComboBoxDatabases(const AComboBox: TComboBox; const AGuidDatabaseDefault: string);
  end;

implementation

uses
  DelphiAIDev.DB.Registers.Fields,
  DelphiAIDev.DB.Registers.Model;

class procedure TDelphiAIDevDBUtils.ClearComboBox(const AComboBox: TComboBox);
var
  i: Integer;
  LObj: TObject;
begin
  for i := 0 to Pred(AComboBox.Items.Count) do
  begin
    if not Assigned(AComboBox.Items.Objects[i]) then
      Continue;

    LObj := AComboBox.Items.Objects[i];

    if LObj is TDelphiAIDevDBRegistersFields then
      TDelphiAIDevDBRegistersFields(LObj).Free;
  end;

  AComboBox.Items.Clear;
end;

class procedure TDelphiAIDevDBUtils.FillComboBoxDatabases(const AComboBox: TComboBox; const AGuidDatabaseDefault: string);
var
  LField: TDelphiAIDevDBRegistersFields;
  LFieldDefault: TDelphiAIDevDBRegistersFields;
  FIndex: Integer;
begin
  Self.ClearComboBox(AComboBox);
  LFieldDefault := nil;

  TDelphiAIDevDBRegistersModel.New.ReadData(
    procedure(AFields: TDelphiAIDevDBRegistersFields)
    begin
      if (not AFields.Visible) or (AFields.Description.Trim.IsEmpty) then
        Exit;

      if AFields.Visible then
      begin
        LField := TDelphiAIDevDBRegistersFields.Create;
        LField.GetDataFromOtherObject(AFields);
        AComboBox.Items.AddObject(LField.Description, LField);

       if LField.Guid = AGuidDatabaseDefault then
         LFieldDefault := LField;
      end;
    end
  );

  AComboBox.ItemIndex := 0;
  if LFieldDefault <> nil then
    AComboBox.ItemIndex := AComboBox.Items.IndexOfObject(LFieldDefault);
end;

end.
