unit DelphiAIDev.DB.Registers.Model;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  Rest.JSON,
  DelphiAIDev.Utils,
  DelphiAIDev.Types,
  DelphiAIDev.DB.Registers.Interfaces,
  DelphiAIDev.DB.Registers.Fields,
  DelphiAIDev.Utils.Crypt;

type
  TDelphiAIDevDBRegistersModel = class(TInterfacedObject, IDelphiAIDevDatabasesModel)
  private
    procedure SaveData(AFields: TDelphiAIDevDBRegistersFields);
    procedure EditData(AFields: TDelphiAIDevDBRegistersFields);
  protected
    procedure ReadData(AProc: TProc<TDelphiAIDevDBRegistersFields>);
    procedure SaveOrEditData(AFields: TDelphiAIDevDBRegistersFields);
    procedure RemoveData(const AGuid: string);
  public
    class function New: IDelphiAIDevDatabasesModel;
    constructor Create;
  end;

implementation

const
  GUID = 'guid';
  DRIVER_ID = 'driver_id';
  DESCRIPTION = 'description';
  HOST = 'host';
  USER = 'user';
  PASSWORD = 'password';
  PORT = 'port';
  DATABASE_NAME = 'database_name';
  VENDOR_LIB = 'vendor_lib';
  VISIBLE = 'visible';

class function TDelphiAIDevDBRegistersModel.New: IDelphiAIDevDatabasesModel;
begin
  Result := Self.Create;
end;

constructor TDelphiAIDevDBRegistersModel.Create;
begin
  //
end;

procedure TDelphiAIDevDBRegistersModel.ReadData(AProc: TProc<TDelphiAIDevDBRegistersFields>);
var
 LStringList: TStringList;
 LJSONObjItem: TJSONObject;
 LJSONArray: TJsonArray;
 i: Integer;
 LFields: TDelphiAIDevDBRegistersFields;
begin
  LFields := TDelphiAIDevDBRegistersFields.Create;
  try
    if not FileExists(TUtils.GetPathFileJSONDatabases) then
    begin
      AProc(LFields);
      Exit;
    end;

    LStringList := TStringList.Create;
    try
      LStringList.LoadFromFile(TUtils.GetPathFileJSONDatabases);
      LJSONArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LStringList.Text), 0) as TJSONArray;
    finally
      LStringList.Free;
    end;

    try
      for i := 0 to Pred(LJSONArray.Count) do
      begin
        if not(LJSONArray.Items[i] is TJSONObject) then
          Continue;

        LJSONObjItem := LJSONArray.Items[i] as TJSONObject;

        if LJSONObjItem.GetValue(GUID) = nil then
          Continue;

        LFields.Clear;
        LFields.Guid := LJSONObjItem.GetValue<string>(GUID);

        if LJSONObjItem.GetValue(DRIVER_ID) <> nil then
          LFields.DriverID := TC4DDriverID(LJSONObjItem.GetValue<Integer>(DRIVER_ID));

        if LJSONObjItem.GetValue(DESCRIPTION) <> nil then
          LFields.Description := LJSONObjItem.GetValue<string>(DESCRIPTION);

        if LJSONObjItem.GetValue(HOST) <> nil then
          LFields.Host := LJSONObjItem.GetValue<string>(HOST);

        if LJSONObjItem.GetValue(USER) <> nil then
          LFields.User := LJSONObjItem.GetValue<string>(USER);

        if LJSONObjItem.GetValue(PASSWORD) <> nil then
          LFields.Password := TUtilsCrypt.Decrypt(LJSONObjItem.GetValue<string>(PASSWORD));

        if LJSONObjItem.GetValue(PORT) <> nil then
          LFields.Port := LJSONObjItem.GetValue<Integer>(PORT);

        if LJSONObjItem.GetValue(DATABASE_NAME) <> nil then
          LFields.DatabaseName := LJSONObjItem.GetValue<string>(DATABASE_NAME);

        if LJSONObjItem.GetValue(VENDOR_LIB) <> nil then
          LFields.VendorLib := LJSONObjItem.GetValue<string>(VENDOR_LIB);

        if LJSONObjItem.GetValue(VISIBLE) <> nil then
          LFields.Visible := LJSONObjItem.GetValue<Boolean>(VISIBLE);

        AProc(LFields);
      end;
    finally
      LJSONArray.Free;
    end;
  finally
    LFields.Free;
  end;
end;

procedure TDelphiAIDevDBRegistersModel.SaveOrEditData(AFields: TDelphiAIDevDBRegistersFields);
begin
  if AFields.Guid.Trim.IsEmpty then
    Self.SaveData(AFields)
  else
    Self.EditData(AFields);
end;

procedure TDelphiAIDevDBRegistersModel.SaveData(AFields: TDelphiAIDevDBRegistersFields);
var
  LStringList: TStringList;
  LJSONArray: TJSONArray;
  LJSONObject: TJSONObject;
begin
  LStringList := TStringList.Create;
  try
    if FileExists(TUtils.GetPathFileJSONDatabases) then
      LStringList.LoadFromFile(TUtils.GetPathFileJSONDatabases);

    LJSONArray := TJSONArray.Create;
    try
      if string(LStringList.Text).Trim.StartsWith('[') then
        LJSONArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LStringList.Text), 0) as TJSONArray;

      LJSONObject := TJSONObject.Create;
      LJSONObject.AddPair(GUID, TUtils.GetGuidStr);
      LJSONObject.AddPair(DRIVER_ID, TJSONNumber.Create(Integer(AFields.DriverID)));
      LJSONObject.AddPair(DESCRIPTION, AFields.Description);
      LJSONObject.AddPair(HOST, AFields.Host);
      LJSONObject.AddPair(USER, AFields.User);
      LJSONObject.AddPair(PASSWORD, TUtilsCrypt.Encrypt(AFields.Password));
      LJSONObject.AddPair(PORT, TJSONNumber.Create(AFields.Port));
      LJSONObject.AddPair(DATABASE_NAME, AFields.DatabaseName);
      LJSONObject.AddPair(VENDOR_LIB, AFields.VendorLib);
      LJSONObject.AddPair(VISIBLE, TJSONBool.Create(AFields.Visible));
      LJSONArray.AddElement(LJSONObject);

      {$IF CompilerVersion <= 32.0} //Tokyo
        LStringList.Text := LJSONArray.ToJSON;
      {$ELSE}
        LStringList.Text := LJSONArray.Format(2);
      {$ENDIF}
    finally
      LJSONArray.Free;
    end;

    LStringList.SaveToFile(TUtils.GetPathFileJSONDatabases);
  finally
    LStringList.Free;
  end;
end;

procedure TDelphiAIDevDBRegistersModel.EditData(AFields: TDelphiAIDevDBRegistersFields);
var
  LStringList: TStringList;
  LJSONArray: TJSONArray;
  LJSONObjItem: TJSONObject;
  i: Integer;
begin
  LStringList := TStringList.Create;
  try
    if FileExists(TUtils.GetPathFileJSONDatabases) then
      LStringList.LoadFromFile(TUtils.GetPathFileJSONDatabases);

    LJSONArray := TJSONArray.Create;
    try
      if string(LStringList.Text).Trim.StartsWith('[') then
        LJSONArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LStringList.Text), 0) as TJSONArray;

      for i := 0 to Pred(LJSONArray.Count) do
      begin
        if not(LJSONArray.Items[i] is TJSONObject) then
          Continue;

        LJSONObjItem := LJSONArray.Items[i] as TJSONObject;

        if LJSONObjItem.GetValue<string>(GUID) = AFields.Guid then
        begin
          LJSONObjItem.RemovePair(DRIVER_ID).Free;
          LJSONObjItem.AddPair(DRIVER_ID, TJSONNumber.Create(Integer(AFields.DriverID)));

          LJSONObjItem.RemovePair(DESCRIPTION).Free;
          LJSONObjItem.AddPair(DESCRIPTION, AFields.Description);

          LJSONObjItem.RemovePair(HOST).Free;
          LJSONObjItem.AddPair(HOST, AFields.Host);

          LJSONObjItem.RemovePair(USER).Free;
          LJSONObjItem.AddPair(USER, AFields.User);

          LJSONObjItem.RemovePair(PASSWORD).Free;
          LJSONObjItem.AddPair(PASSWORD, TUtilsCrypt.Encrypt(AFields.Password));

          LJSONObjItem.RemovePair(PORT).Free;
          LJSONObjItem.AddPair(PORT, TJSONNumber.Create(AFields.Port));

          LJSONObjItem.RemovePair(DATABASE_NAME).Free;
          LJSONObjItem.AddPair(DATABASE_NAME, AFields.DatabaseName);

          LJSONObjItem.RemovePair(VENDOR_LIB).Free;
          LJSONObjItem.AddPair(VENDOR_LIB, AFields.VendorLib);

          LJSONObjItem.RemovePair(VISIBLE).Free;
          LJSONObjItem.AddPair(VISIBLE, TJSONBool.Create(AFields.Visible));

          Break;
        end;
      end;

      {$IF CompilerVersion <= 32.0} //Tokyo
        LStringList.Text := LJSONArray.ToJSON;
      {$ELSE}
        LStringList.Text := LJSONArray.Format(2);
      {$ENDIF}
    finally
      LJSONArray.Free;
    end;

    LStringList.SaveToFile(TUtils.GetPathFileJSONDatabases);
  finally
    LStringList.Free;
  end;
end;

procedure TDelphiAIDevDBRegistersModel.RemoveData(const AGuid: string);
var
  LStringList: TStringList;
  LJSONArray: TJSONArray;
  LJSONObjItem: TJSONObject;
  i: Integer;
begin
  if AGuid.Trim.IsEmpty then
    Exit;

  if not FileExists(TUtils.GetPathFileJSONDatabases) then
    Exit;

  LStringList := TStringList.Create;
  try
    LStringList.LoadFromFile(TUtils.GetPathFileJSONDatabases);
    if not string(LStringList.Text).Trim.StartsWith('[') then
      Exit;

    LJSONArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LStringList.Text), 0) as TJSONArray;
    try
      for i := 0 to Pred(LJSONArray.Count) do
      begin
        if not(LJSONArray.Items[i] is TJSONObject) then
          Continue;

        LJSONObjItem := LJSONArray.Items[i] as TJSONObject;
        if LJSONObjItem.GetValue<string>(GUID) = AGuid then
        begin
          LJSONArray.Remove(i);
          Break;
        end;
      end;

      {$IF CompilerVersion <= 32.0} //Tokyo
        LStringList.Text := LJSONArray.ToJSON;
      {$ELSE}
        LStringList.Text := LJSONArray.Format(2);
      {$ENDIF}
    finally
      LJSONArray.Free;
    end;

    LStringList.SaveToFile(TUtils.GetPathFileJSONDatabases);
  finally
    LStringList.Free;
  end;
end;

end.
