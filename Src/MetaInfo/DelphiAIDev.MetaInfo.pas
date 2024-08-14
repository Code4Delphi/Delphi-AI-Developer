unit DelphiAIDev.MetaInfo;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Json,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  C4D.Conn,
  DelphiAIDev.Utils,
  DelphiAIDev.DB.Registers.Fields;

type
  TDelphiAIDevMetaInfo = class
  private
    FField: TDelphiAIDevDBRegistersFields;
    FC4DConn: IC4DConn;
    FMetaInfoTables: TFDMetaInfoQuery;
    FMetaInfoFields: TFDMetaInfoQuery;
    procedure ConfigConn;
    procedure SaveJsonInFolder(const AJSONArrayTables: TJSONArray);
  public
    constructor Create(const AField: TDelphiAIDevDBRegistersFields);
    destructor Destroy; override;
    procedure Process;
  end;

implementation

constructor TDelphiAIDevMetaInfo.Create(const AField: TDelphiAIDevDBRegistersFields);
begin
  FField := AField;
  FC4DConn := TC4DConn.New;
  Self.ConfigConn;

  FMetaInfoTables := TFDMetaInfoQuery.Create(nil);
  FMetaInfoTables.Connection := TFDConnection(FC4DConn.Connection.Component);
  FMetaInfoTables.MetaInfoKind := mkTables;

  FMetaInfoFields := TFDMetaInfoQuery.Create(nil);
  FMetaInfoFields.Connection := TFDConnection(FC4DConn.Connection.Component);
  FMetaInfoFields.MetaInfoKind := mkTableFields;
end;

destructor TDelphiAIDevMetaInfo.Destroy;
begin
  FMetaInfoFields.Free;
  FMetaInfoTables.Free;
  inherited;
end;

procedure TDelphiAIDevMetaInfo.ConfigConn;
begin
  FC4DConn.Configs
    .DriverID(FField.DriverID)
    .Host(FField.Host)
    .UserName(FField.User)
    .Password(FField.Password)
    .Port(FField.Port)
    .Database(FField.DatabaseName)
    .VendorLib(FField.VendorLib);
end;

procedure TDelphiAIDevMetaInfo.Process;
var
  LJSONArrayTables: TJSONArray;
  LJSONObjectTable: TJSONObject;
  LJSONArrayColumns: TJSONArray;
  LJSONObjectColumn: TJSONObject;
begin
  FC4DConn.Connection.Open;

  FMetaInfoTables.Open;
  if FMetaInfoTables.IsEmpty then
    TUtils.ShowMsgAndAbort('No tables could be found in the current connection');

  LJSONArrayTables := TJSONArray.Create;
  try
    FMetaInfoTables.First;
    while not FMetaInfoTables.Eof do
    begin
      FMetaInfoFields.Close;
      FMetaInfoFields.ObjectName := FMetaInfoTables.FieldByName('TABLE_NAME').AsString;
      FMetaInfoFields.Open;

      LJSONArrayColumns := TJSONArray.Create;
      FMetaInfoFields.First;
      while not FMetaInfoFields.Eof do
      begin
        LJSONObjectColumn := TJSONObject.Create;
        LJSONObjectColumn.AddPair('name', TJSONString.Create(FMetaInfoFields.FieldByName('COLUMN_NAME').AsString));
        LJSONObjectColumn.AddPair('type', TJSONString.Create(FMetaInfoFields.FieldByName('COLUMN_TYPENAME').AsString));
        LJSONObjectColumn.AddPair('length', TJSONNumber.Create(FMetaInfoFields.FieldByName('COLUMN_LENGTH').AsInteger));

        LJSONArrayColumns.AddElement(LJSONObjectColumn);
        FMetaInfoFields.Next;
      end;

      LJSONObjectTable := TJSONObject.Create;
      LJSONObjectTable.AddPair('name', TJSONString.Create(FMetaInfoTables.FieldByName('TABLE_NAME').AsString));
      LJSONObjectTable.AddPair('columns', LJSONArrayColumns);
      LJSONArrayTables.AddElement(LJSONObjectTable);

      FMetaInfoTables.Next;
    end;

    TUtils.ShowMsg('Terminou', LJSONArrayTables.Format);
    Self.SaveJsonInFolder(LJSONArrayTables);
  finally
    LJSONArrayTables.Free;
  end;
end;

procedure TDelphiAIDevMetaInfo.SaveJsonInFolder(const AJSONArrayTables: TJSONArray);
var
  LStringList: TStringList;
begin
  LStringList := TStringList.Create;
  try
//    {$IF CompilerVersion <= 32.0} //Tokyo
//      LStringList.Text := AJSONArrayTables.ToJSON;
//    {$ELSE}
//      LStringList.Text := AJSONArrayTables.Format(2);
//    {$ENDIF}

    LStringList.Text := AJSONArrayTables.ToString;

    LStringList.SaveToFile(TUtils.GetPathFolderMetaInfo + FField.Guid + '.json');
  finally
    LStringList.Free;
  end;
end;

end.
