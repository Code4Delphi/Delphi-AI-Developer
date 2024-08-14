unit DelphiAIDev.MetaInfo;

interface

uses
  System.SysUtils,
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
  DelphiAIDev.Utils;

type
  TDelphiAIDevMetaInfo = class
  private
    FC4DConn: IC4DConn;
    FMetaInfoTables: TFDMetaInfoQuery;
    FMetaInfoFields: TFDMetaInfoQuery;
  public
    constructor Create(const AC4DConn: IC4DConn);
    destructor Destroy; override;
    procedure Process;
  end;

implementation


constructor TDelphiAIDevMetaInfo.Create(const AC4DConn: IC4DConn);
begin
  FC4DConn := AC4DConn;

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

procedure TDelphiAIDevMetaInfo.Process;
var
  LJSONArrayTables: TJSONArray;
  LJSONObjectTable: TJSONObject;
  LJSONArrayColumns: TJSONArray;
  LJSONObjectColumn: TJSONObject;
begin
  FMetaInfoTables.Open;
  if FMetaInfoTables.IsEmpty then
    TUtils.ShowMsgAndAbort('No tables could be found in the current connection');

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
      LJSONObjectColumn := TJSONObject.Create;
      LJSONObjectColumn.AddPair('name', TJSONString.Create(FMetaInfoFields.FieldByName('COLUMN_NAME').AsString));
      LJSONObjectColumn.AddPair('type', TJSONString.Create(FMetaInfoFields.FieldByName('COLUMN_TYPENAME').AsString));
      LJSONObjectColumn.AddPair('length', TJSONNumber.Create(FMetaInfoFields.FieldByName('COLUMN_LENGTH').AsInteger));

      LJSONArrayColumns.AddElement(LJSONObjectColumn);
      FMetaInfoFields.Next;
    end;

    LJSONObjectTable := TJSONObject.Create;
    LJSONObjectTable.AddPair('table_name', TJSONString.Create(FMetaInfoTables.FieldByName('TABLE_NAME').AsString));
    LJSONObjectTable.AddPair('columns', LJSONArrayColumns);
    LJSONArrayTables.AddElement(LJSONObjectTable);

    FMetaInfoTables.Next;
  end;

  TUtils.ShowMsg('Terminou', LJSONArrayTables.Format);
end;

end.
