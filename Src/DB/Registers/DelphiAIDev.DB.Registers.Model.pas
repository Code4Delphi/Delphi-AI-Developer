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
    procedure FillField(const AJSONObjItem: TJSONObject; var AField: TDelphiAIDevDBRegistersFields);
  protected
    function ReadGuid(const AGuid: string): TDelphiAIDevDBRegistersFields;
    procedure ReadData(AProc: TProc<TDelphiAIDevDBRegistersFields>; const AAutoFreeField: TAutoFreeField = TAutoFreeField.Yes);
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
  LAST_REFERENCE = 'last_reference';

class function TDelphiAIDevDBRegistersModel.New: IDelphiAIDevDatabasesModel;
begin
  Result := Self.Create;
end;

constructor TDelphiAIDevDBRegistersModel.Create;
begin
  //
end;

function TDelphiAIDevDBRegistersModel.ReadGuid(const AGuid: string): TDelphiAIDevDBRegistersFields;
var
 LStringList: TStringList;
 LJSONObjItem: TJSONObject;
 LJSONArray: TJsonArray;
 i: Integer;
begin
  Result := TDelphiAIDevDBRegistersFields.Create;

  if not FileExists(TUtils.GetPathFileJSONDatabases) then
    Exit;

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

      if LJSONObjItem.GetValue<string>(GUID) <> AGuid then
        Continue;

      Self.FillField(LJSONObjItem, Result);
      Break;
    end;
  finally
    LJSONArray.Free;
  end;
end;

procedure TDelphiAIDevDBRegistersModel.FillField(const AJSONObjItem: TJSONObject; var AField: TDelphiAIDevDBRegistersFields);
begin
  AField.Clear;
  AField.Guid := AJSONObjItem.GetValue<string>(GUID);

  if AJSONObjItem.GetValue(DRIVER_ID) <> nil then
    AField.DriverID := TC4DDriverID(AJSONObjItem.GetValue<Integer>(DRIVER_ID));

  if AJSONObjItem.GetValue(DESCRIPTION) <> nil then
    AField.Description := AJSONObjItem.GetValue<string>(DESCRIPTION);

  if AJSONObjItem.GetValue(HOST) <> nil then
    AField.Host := AJSONObjItem.GetValue<string>(HOST);

  if AJSONObjItem.GetValue(USER) <> nil then
    AField.User := AJSONObjItem.GetValue<string>(USER);

  if AJSONObjItem.GetValue(PASSWORD) <> nil then
    AField.Password := TUtilsCrypt.Decrypt(AJSONObjItem.GetValue<string>(PASSWORD));

  if AJSONObjItem.GetValue(PORT) <> nil then
    AField.Port := AJSONObjItem.GetValue<Integer>(PORT);

  if AJSONObjItem.GetValue(DATABASE_NAME) <> nil then
    AField.DatabaseName := AJSONObjItem.GetValue<string>(DATABASE_NAME);

  if AJSONObjItem.GetValue(VENDOR_LIB) <> nil then
    AField.VendorLib := AJSONObjItem.GetValue<string>(VENDOR_LIB);

  if AJSONObjItem.GetValue(VISIBLE) <> nil then
    AField.Visible := AJSONObjItem.GetValue<Boolean>(VISIBLE);

  if AJSONObjItem.GetValue(LAST_REFERENCE) <> nil then
    AField.LastReferences := StrToDateTimeDef(AJSONObjItem.GetValue<string>(LAST_REFERENCE), 0);
end;

procedure TDelphiAIDevDBRegistersModel.ReadData(AProc: TProc<TDelphiAIDevDBRegistersFields>; const AAutoFreeField: TAutoFreeField = TAutoFreeField.Yes);
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

        Self.FillField(LJSONObjItem, LFields);

        AProc(LFields);
      end;
    finally
      LJSONArray.Free;
    end;
  finally
    if AAutoFreeField = TAutoFreeField.Yes then
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
      LJSONObject.AddPair(LAST_REFERENCE, TJSONString.Create(TUtils.DateTimeToStrEmpty(AFields.LastReferences)));
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

          LJSONObjItem.RemovePair(LAST_REFERENCE).Free;
          LJSONObjItem.AddPair(LAST_REFERENCE, TJSONString.Create(TUtils.DateTimeToStrEmpty(AFields.LastReferences)));

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
