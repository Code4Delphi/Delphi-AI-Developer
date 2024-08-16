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
  DelphiAIDev.DB.Registers.Fields,
  DelphiAIDev.DB.Registers.Model;

type
  TDelphiAIDevMetaInfo = class
  private
    FField: TDelphiAIDevDBRegistersFields;
    FC4DConn: IC4DConn;
    FMetaInfoTables: TFDMetaInfoQuery;
    FMetaInfoFields: TFDMetaInfoQuery;
    FAddFieldSize: Boolean;
    procedure ConfigConn;
    procedure SaveJsonInFolder(const AJSONObject: TJSONObject);
    procedure SaveGenerationDataToField;
  public
    constructor Create(const AField: TDelphiAIDevDBRegistersFields);
    destructor Destroy; override;
    procedure Process;

    property AddFieldSize: Boolean read FAddFieldSize write FAddFieldSize;
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
const
{.$DEFINE C4D_SHORT_KEY}
{$IFDEF C4D_SHORT_KEY}
  KEY_NAME = 'N';
  KEY_TYPE = 'T';
  KEY_LENGTH = 'L';
  KEY_COLUMNS = 'c';
{$ELSE}
  KEY_NAME = 'name';
  KEY_TYPE = 'type';
  KEY_LENGTH = 'length';
  KEY_COLUMNS = 'columns';
{$ENDIF}
var
  LJSONObjAll: TJSONObject;
  LJSONArrayTables: TJSONArray;
  LJSONObjTable: TJSONObject;
  LJSONArrayColumns: TJSONArray;
  LJSONObjColumn: TJSONObject;
begin
  FC4DConn.Connection.Open;

  FMetaInfoTables.Open;
  if FMetaInfoTables.IsEmpty then
    TUtils.ShowMsgAndAbort('No tables could be found in the current connection');

  LJSONObjAll := TJSONObject.Create;
  try
    LJSONObjAll.AddPair('Instructions', 'Teste');

    LJSONArrayTables := TJSONArray.Create;

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
        LJSONObjColumn := TJSONObject.Create;
        LJSONObjColumn.AddPair(KEY_NAME, TJSONString.Create(FMetaInfoFields.FieldByName('COLUMN_NAME').AsString));
        LJSONObjColumn.AddPair(KEY_TYPE, TJSONString.Create(FMetaInfoFields.FieldByName('COLUMN_TYPENAME').AsString));
        if FAddFieldSize then
          LJSONObjColumn.AddPair(KEY_LENGTH, TJSONNumber.Create(FMetaInfoFields.FieldByName('COLUMN_LENGTH').AsInteger));

        LJSONArrayColumns.AddElement(LJSONObjColumn);
        FMetaInfoFields.Next;
      end;

      LJSONObjTable := TJSONObject.Create;
      LJSONObjTable.AddPair(KEY_NAME, TJSONString.Create(FMetaInfoTables.FieldByName('TABLE_NAME').AsString));
      LJSONObjTable.AddPair(KEY_COLUMNS, LJSONArrayColumns);
      LJSONArrayTables.AddElement(LJSONObjTable);

      FMetaInfoTables.Next;
    end;

    LJSONObjAll.AddPair('tables', LJSONArrayTables);
    Self.SaveJsonInFolder(LJSONObjAll);
    Self.SaveGenerationDataToField;

    TUtils.ShowMsg('Terminou', LJSONObjAll.Format);
  finally
    LJSONObjAll.Free;
  end;
end;

procedure TDelphiAIDevMetaInfo.SaveGenerationDataToField;
begin
  FField.LastReferences := Now;
  TDelphiAIDevDBRegistersModel.New.SaveOrEditData(FField);
end;

procedure TDelphiAIDevMetaInfo.SaveJsonInFolder(const AJSONObject: TJSONObject);
var
  LStringList: TStringList;
begin
  LStringList := TStringList.Create;
  try
//    {$IF CompilerVersion <= 32.0} //Tokyo
//      LStringList.Text := AJSONObject.ToJSON;
//    {$ELSE}
//      LStringList.Text := AJSONObject.Format(2);
//    {$ENDIF}

    LStringList.Text := AJSONObject.ToString;
    LStringList.SaveToFile(TUtils.GetPathFolderMetaInfo + FField.Guid + '.json');
  finally
    LStringList.Free;
  end;
end;

end.
