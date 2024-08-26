unit DelphiAIDev.Projects.Model;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  Rest.JSON,
  DelphiAIDev.Utils,
  DelphiAIDev.Types,
  DelphiAIDev.Projects.Interfaces,
  DelphiAIDev.Projects.Fields;

type
  TDelphiAIDevProjectsModel = class(TInterfacedObject, IDelphiAIDevProjectsModel)
  private
    procedure SaveData(AFields: TDelphiAIDevProjectsFields);
    procedure EditData(AFields: TDelphiAIDevProjectsFields);
    procedure FillField(const AJSONObjItem: TJSONObject; var AField: TDelphiAIDevProjectsFields);
  protected
    function ReadGuid(const AGuid: string): TDelphiAIDevProjectsFields;
    function ReadFilePath(const AFilePath: string): TDelphiAIDevProjectsFields;
    procedure ReadData(AProc: TProc<TDelphiAIDevProjectsFields>; const AAutoFreeField: TAutoFreeField = TAutoFreeField.Yes);
    procedure SaveOrEditData(AFields: TDelphiAIDevProjectsFields);
    procedure RemoveData(const AGuid: string);
  public
    class function New: IDelphiAIDevProjectsModel;
    constructor Create;
  end;

implementation

const
  GUID = 'guid';
  FILE_PATH = 'file_path';
  DESCRIPTION = 'description';
  GUID_DATABASE_DEFAULT = 'guid_database_default';

class function TDelphiAIDevProjectsModel.New: IDelphiAIDevProjectsModel;
begin
  Result := Self.Create;
end;

constructor TDelphiAIDevProjectsModel.Create;
begin
  //
end;

function TDelphiAIDevProjectsModel.ReadGuid(const AGuid: string): TDelphiAIDevProjectsFields;
var
 LStringList: TStringList;
 LJSONObjItem: TJSONObject;
 LJSONArray: TJsonArray;
 i: Integer;
begin
  Result := TDelphiAIDevProjectsFields.Create;

  if not FileExists(TUtils.GetPathFileJSONProjects) then
    Exit;

  LStringList := TStringList.Create;
  try
    LStringList.LoadFromFile(TUtils.GetPathFileJSONProjects);
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

function TDelphiAIDevProjectsModel.ReadFilePath(const AFilePath: string): TDelphiAIDevProjectsFields;
var
 LStringList: TStringList;
 LJSONObjItem: TJSONObject;
 LJSONArray: TJsonArray;
 i: Integer;
begin
  Result := TDelphiAIDevProjectsFields.Create;

  if AFilePath.Trim.IsEmpty then
    Exit;

  if not FileExists(TUtils.GetPathFileJSONProjects) then
    Exit;

  LStringList := TStringList.Create;
  try
    LStringList.LoadFromFile(TUtils.GetPathFileJSONProjects);
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

      if LJSONObjItem.GetValue(FILE_PATH) = nil then
        Continue;

      if LJSONObjItem.GetValue<string>(FILE_PATH) <> AFilePath then
        Continue;

      Self.FillField(LJSONObjItem, Result);
      Break;
    end;
  finally
    LJSONArray.Free;
  end;
end;

procedure TDelphiAIDevProjectsModel.FillField(const AJSONObjItem: TJSONObject;
  var AField: TDelphiAIDevProjectsFields);
begin
  AField.Clear;
  AField.Guid := AJSONObjItem.GetValue<string>(GUID);

  if AJSONObjItem.GetValue(FILE_PATH) <> nil then
    AField.FilePath := AJSONObjItem.GetValue<string>(FILE_PATH);

  if AJSONObjItem.GetValue(DESCRIPTION) <> nil then
    AField.Description := AJSONObjItem.GetValue<string>(DESCRIPTION);

  if AJSONObjItem.GetValue(GUID_DATABASE_DEFAULT) <> nil then
    AField.GuidDatabaseDefault := AJSONObjItem.GetValue<string>(GUID_DATABASE_DEFAULT);
end;

procedure TDelphiAIDevProjectsModel.ReadData(AProc: TProc<TDelphiAIDevProjectsFields>;
  const AAutoFreeField: TAutoFreeField = TAutoFreeField.Yes);
var
 LStringList: TStringList;
 LJSONObjItem: TJSONObject;
 LJSONArray: TJsonArray;
 i: Integer;
 LFields: TDelphiAIDevProjectsFields;
begin
  LFields := TDelphiAIDevProjectsFields.Create;
  try
    if not FileExists(TUtils.GetPathFileJSONProjects) then
    begin
      AProc(LFields);
      Exit;
    end;

    LStringList := TStringList.Create;
    try
      LStringList.LoadFromFile(TUtils.GetPathFileJSONProjects);
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

procedure TDelphiAIDevProjectsModel.SaveOrEditData(AFields: TDelphiAIDevProjectsFields);
begin
  if AFields.Guid.Trim.IsEmpty then
    Self.SaveData(AFields)
  else
    Self.EditData(AFields);
end;

procedure TDelphiAIDevProjectsModel.SaveData(AFields: TDelphiAIDevProjectsFields);
var
  LStringList: TStringList;
  LJSONArray: TJSONArray;
  LJSONObject: TJSONObject;
begin
  LStringList := TStringList.Create;
  try
    if FileExists(TUtils.GetPathFileJSONProjects) then
      LStringList.LoadFromFile(TUtils.GetPathFileJSONProjects);

    LJSONArray := TJSONArray.Create;
    try
      if string(LStringList.Text).Trim.StartsWith('[') then
        LJSONArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LStringList.Text), 0) as TJSONArray;

      LJSONObject := TJSONObject.Create;
      LJSONObject.AddPair(GUID, TUtils.GetGuidStr);
      LJSONObject.AddPair(FILE_PATH, AFields.FilePath);
      LJSONObject.AddPair(DESCRIPTION, AFields.Description);
      LJSONObject.AddPair(GUID_DATABASE_DEFAULT, AFields.GuidDatabaseDefault);
      LJSONArray.AddElement(LJSONObject);

      {$IF CompilerVersion <= 32.0} //Tokyo
        LStringList.Text := LJSONArray.ToJSON;
      {$ELSE}
        LStringList.Text := LJSONArray.Format(2);
      {$ENDIF}
    finally
      LJSONArray.Free;
    end;

    LStringList.SaveToFile(TUtils.GetPathFileJSONProjects);
  finally
    LStringList.Free;
  end;
end;

procedure TDelphiAIDevProjectsModel.EditData(AFields: TDelphiAIDevProjectsFields);
var
  LStringList: TStringList;
  LJSONArray: TJSONArray;
  LJSONObjItem: TJSONObject;
  i: Integer;
begin
  LStringList := TStringList.Create;
  try
    if FileExists(TUtils.GetPathFileJSONProjects) then
      LStringList.LoadFromFile(TUtils.GetPathFileJSONProjects);

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
          LJSONObjItem.RemovePair(FILE_PATH).Free;
          LJSONObjItem.AddPair(FILE_PATH, AFields.FilePath);

          LJSONObjItem.RemovePair(DESCRIPTION).Free;
          LJSONObjItem.AddPair(DESCRIPTION, AFields.Description);

          LJSONObjItem.RemovePair(GUID_DATABASE_DEFAULT).Free;
          LJSONObjItem.AddPair(GUID_DATABASE_DEFAULT, AFields.GuidDatabaseDefault);

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

    LStringList.SaveToFile(TUtils.GetPathFileJSONProjects);
  finally
    LStringList.Free;
  end;
end;

procedure TDelphiAIDevProjectsModel.RemoveData(const AGuid: string);
var
  LStringList: TStringList;
  LJSONArray: TJSONArray;
  LJSONObjItem: TJSONObject;
  i: Integer;
begin
  if AGuid.Trim.IsEmpty then
    Exit;

  if not FileExists(TUtils.GetPathFileJSONProjects) then
    Exit;

  LStringList := TStringList.Create;
  try
    LStringList.LoadFromFile(TUtils.GetPathFileJSONProjects);
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

    LStringList.SaveToFile(TUtils.GetPathFileJSONProjects);
  finally
    LStringList.Free;
  end;
end;

end.
