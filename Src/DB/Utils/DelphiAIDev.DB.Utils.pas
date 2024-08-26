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
    class procedure FillComboBoxDatabases(const AComboBox: TComboBox);
    class procedure SelectByGuidDatabase(const AComboBox: TComboBox; const AGuidDatabase);
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

class procedure TDelphiAIDevDBUtils.FillComboBoxDatabases(const AComboBox: TComboBox);
var
  LField: TDelphiAIDevDBRegistersFields;
begin
  Self.ClearComboBox(AComboBox);

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
      end;
    end
  );

  AComboBox.ItemIndex := 0;
end;

class procedure TDelphiAIDevDBUtils.SelectByGuidDatabase(const AComboBox: TComboBox; const AGuidDatabase);
begin
  AComboBox
end;

end.
