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
  DelphiAIDev.Types,
  DelphiAIDev.DB.Registers.Fields,
  DelphiAIDev.DB.Registers.Model;

type
  TDelphiAIDevMetaInfo = class
  private
    FField: TDelphiAIDevDBRegistersFields;
    FC4DConn: IC4DConn;
    FMetaInfoTables: TFDMetaInfoQuery;
    FMetaInfoFields: TFDMetaInfoQuery;
    FAddFieldLength: Boolean;
    FCompressData: Boolean;

    FKeyName: string;
    FKeyTYPE: string;
    FKeyLength: string;
    FKeyColumns: string;

    procedure ConfigConn;
    procedure SaveJsonInFolder(const AJSONObject: TJSONObject);
    procedure SaveGenerationDataToField;
    function GetInstructionsNamesKeysCompress: string;
    procedure ProcessNamesKeys;
  public
    constructor Create(const AField: TDelphiAIDevDBRegistersFields);
    destructor Destroy; override;
    procedure Process;

    property AddFieldLength: Boolean read FAddFieldLength write FAddFieldLength;
    property CompressData: Boolean read FCompressData write FCompressData;
  end;

implementation

const
  KEY_NAME = 'name';
  KEY_TYPE = 'type';
  KEY_LENGTH = 'length';
  KEY_COLUMNS = 'columns';

  KEY_NAME_SHORT = 'n';
  KEY_TYPE_SHORT = 't';
  KEY_LENGTH_SHORT = 'l';
  KEY_COLUMNS_SHORT = 'c';

constructor TDelphiAIDevMetaInfo.Create(const AField: TDelphiAIDevDBRegistersFields);
begin
  FAddFieldLength := False;
  FCompressData := False;

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

procedure TDelphiAIDevMetaInfo.ProcessNamesKeys;
begin
  FKeyName := KEY_NAME;
  FKeyTYPE := KEY_TYPE;
  FKeyLength := KEY_LENGTH;
  FKeyColumns := KEY_COLUMNS;

  if FCompressData then
  begin
    FKeyName := KEY_NAME_SHORT;
    FKeyTYPE := KEY_TYPE_SHORT;
    FKeyLength := KEY_LENGTH_SHORT;
    FKeyColumns := KEY_COLUMNS_SHORT;
  end;
end;

function TDelphiAIDevMetaInfo.GetInstructionsNamesKeysCompress: string;
begin
  Result := 'Some JSON keys have been abbreviated, here is the legend for the abbreviations: ' +
    Format('%s = %s; ', [KEY_NAME_SHORT, KEY_NAME]) +
    Format('%s = %s; ', [KEY_TYPE_SHORT, KEY_TYPE]) +
    Format('%s = %s; ', [KEY_LENGTH_SHORT, KEY_LENGTH]) +
    Format('%s = %s. ', [KEY_COLUMNS_SHORT, KEY_COLUMNS]);
end;

procedure TDelphiAIDevMetaInfo.Process;
var
  LJSONObjAll: TJSONObject;
  LJSONArrayTables: TJSONArray;
  LJSONObjTable: TJSONObject;
  LJSONArrayColumns: TJSONArray;
  LJSONObjColumn: TJSONObject;
begin
  Self.ProcessNamesKeys;
  FC4DConn.Connection.Open;

  FMetaInfoTables.Open;
  if FMetaInfoTables.IsEmpty then
    TUtils.ShowMsgAndAbort('No tables could be found in the current connection');

  LJSONObjAll := TJSONObject.Create;
  try
    if FCompressData then
     LJSONObjAll.AddPair('instructions', Self.GetInstructionsNamesKeysCompress);

    LJSONObjAll.AddPair('SGBD (database)', FField.DriverID.ToString);
    LJSONObjAll.AddPair('database name', FField.DatabaseName);

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
        LJSONObjColumn.AddPair(FKeyName, TJSONString.Create(FMetaInfoFields.FieldByName('COLUMN_NAME').AsString));
        LJSONObjColumn.AddPair(FKeyType, TJSONString.Create(FMetaInfoFields.FieldByName('COLUMN_TYPENAME').AsString));
        if FAddFieldLength then
          LJSONObjColumn.AddPair(FKeyLength, TJSONNumber.Create(FMetaInfoFields.FieldByName('COLUMN_LENGTH').AsInteger));

        LJSONArrayColumns.AddElement(LJSONObjColumn);
        FMetaInfoFields.Next;
      end;

      LJSONObjTable := TJSONObject.Create;
      LJSONObjTable.AddPair(FKeyName, TJSONString.Create(FMetaInfoTables.FieldByName('TABLE_NAME').AsString));
      LJSONObjTable.AddPair(FKeyColumns, LJSONArrayColumns);
      LJSONArrayTables.AddElement(LJSONObjTable);

      FMetaInfoTables.Next;
    end;

    LJSONObjAll.AddPair('tables', LJSONArrayTables);
    Self.SaveJsonInFolder(LJSONObjAll);
    Self.SaveGenerationDataToField;

    TUtils.ShowV('Process completed');
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
