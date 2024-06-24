unit C4D.Conn.Zeos.Query;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  System.Generics.Collections,
  ZAbstractConnection,
  ZConnection,
  Data.DB,
  ZAbstractRODataset,
  ZAbstractDataset,
  ZDataset,
  C4D.Conn.Interfaces,
  C4D.Conn.Zeos,
  C4D.Conn.Utils;

type
  TC4DConnZeosQuery = class(TInterfacedObject, IC4DConnQuery)
  private
    FC4DConnection: IC4DConnection;
    FQuery: TZQuery;
    FListCond: TStringList;
    FListCondParam: TDictionary<string, Variant>;
    FListGroup: TStringList;
    FListOrder: TStringList;
    FListLimit: TStringList;
    procedure ProcessaListCond;
    procedure ProcessaListGroup;
    procedure ProcessaListOrder;
    procedure ProcessaListLimit;
    procedure CriaCamposDaQuery;
  protected
    function Close: IC4DConnQuery;
    function Clear: IC4DConnQuery;
    function CloseClear: IC4DConnQuery;
    function Add(Value: string): IC4DConnQuery;
    function AddParam(Param: string; Value: Variant): IC4DConnQuery;
    function AddCond(ACond: string): IC4DConnQuery;
    function AddCondParam(Param: string; Value: Variant): IC4DConnQuery;
    function AddGroup(ACond: string): IC4DConnQuery;
    function AddOrder(ACond: string): IC4DConnQuery;
    function AddLimit(ACond: string): IC4DConnQuery;
    function Text(Value: string): IC4DConnQuery;
    function SQL: TStrings;
    function ExecSQL: IC4DConnQuery; overload;
    function ExecSQL(const ASQL: string): IC4DConnQuery; overload;
    function Open: IC4DConnQuery; overload;
    function Open(const ASQL: string): IC4DConnQuery; overload;

    function DataSet: TDataSet;
    function DataSource(Value: TDataSource): IC4DConnQuery;
    function DataSourceMasterDetail(Value: TDataSource): IC4DConnQuery;

    function Append: IC4DConnQuery;
    function Edit: IC4DConnQuery;
    function Post: IC4DConnQuery;
    function Delete: IC4DConnQuery;

    function Eof: Boolean;
    function Bof: Boolean;
    function Prior: IC4DConnQuery;
    function Next: IC4DConnQuery;
    function First: IC4DConnQuery;
    function Last: IC4DConnQuery;
    function IsEmpty: Boolean;
    function RowsAffected: Integer;
    function FieldByName(Value: string): TField;
    function RecNo: Integer;
    function RecordCount: Integer;
    function RecordCountStr(ANumZerosLeft: Integer = 6): string;
    function GetLastAutoGenValue(const AName: string): Variant;
  public
    class function New(AC4DConnection: IC4DConnection; ANameQuery: string): IC4DConnQuery;
    constructor Create(AC4DConnection: IC4DConnection; ANameQuery: string);
    destructor Destroy; override;
  end;

implementation

class function TC4DConnZeosQuery.New(AC4DConnection: IC4DConnection; ANameQuery: string): IC4DConnQuery;
begin
  Result := Self.Create(AC4DConnection, ANameQuery);
end;

constructor TC4DConnZeosQuery.Create(AC4DConnection: IC4DConnection; ANameQuery: string);
begin
  FC4DConnection := AC4DConnection;

  FQuery := TZQuery.Create(nil);
  FQuery.Name := ANameQuery;
  FQuery.Connection := TZConnection(FC4DConnection.Component);

  FQuery.Close;
  FQuery.SQL.Clear;

  FListCond := TStringList.Create;
  FListCondParam := TDictionary<string, Variant>.Create;
  FListGroup := TStringList.Create;
  FListOrder := TStringList.Create;
  FListLimit := TStringList.Create;
end;

destructor TC4DConnZeosQuery.Destroy;
begin
  FListLimit.Free;
  FListOrder.Free;
  FListGroup.Free;
  FListCondParam.Free;
  FListCond.Free;
  FreeAndNil(FQuery);
  inherited;
end;

function TC4DConnZeosQuery.Close: IC4DConnQuery;
begin
  Result := Self;
  FQuery.Close;
end;

function TC4DConnZeosQuery.Clear: IC4DConnQuery;
begin
  Result := Self;
  FQuery.SQL.Clear;
  FListCond.Clear;
  FListCondParam.Clear;
  FListLimit.Clear;
  FListGroup.Clear;
  FListOrder.Clear;
end;

function TC4DConnZeosQuery.CloseClear: IC4DConnQuery;
begin
  Result := Self;
  Self.Close;
  Self.Clear;
end;

function TC4DConnZeosQuery.Add(Value: string): IC4DConnQuery;
begin
  Result := Self;
  FQuery.SQL.Add(Value);
end;

function TC4DConnZeosQuery.AddParam(Param: string; Value: Variant): IC4DConnQuery;
begin
  Result := Self;
  FQuery.ParamByName(Param).Value := Value;
end;

function TC4DConnZeosQuery.AddCond(ACond: string): IC4DConnQuery;
begin
  Result := Self;
  FListCond.Add(ACond);
end;

function TC4DConnZeosQuery.AddCondParam(Param: string; Value: Variant): IC4DConnQuery;
begin
  Result := Self;
  FListCondParam.Add(Param, Value);
end;

function TC4DConnZeosQuery.AddGroup(ACond: string): IC4DConnQuery;
begin
  Result := Self;
  FListGroup.Add(ACond);
end;

function TC4DConnZeosQuery.AddOrder(ACond: string): IC4DConnQuery;
begin
  Result := Self;
  FListOrder.Add(ACond);
end;

function TC4DConnZeosQuery.AddLimit(ACond: string): IC4DConnQuery;
begin
  Result := Self;
  FListLimit.Add(ACond);
end;

function TC4DConnZeosQuery.Text(Value: string): IC4DConnQuery;
begin
  Result := Self;
  FQuery.SQL.Text := Value;
end;

function TC4DConnZeosQuery.ExecSQL: IC4DConnQuery;
begin
  Result := Self;
  FQuery.ExecSQL;
end;

function TC4DConnZeosQuery.ExecSQL(const ASQL: string): IC4DConnQuery;
begin
  Result := Self;
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(ASQL);
  FQuery.ExecSQL;
end;

function TC4DConnZeosQuery.Open: IC4DConnQuery;
begin
  Result := Self;
  Self.ProcessaListCond;
  Self.ProcessaListGroup;
  Self.ProcessaListOrder;
  Self.ProcessaListLimit;
  Self.CriaCamposDaQuery;
  FQuery.Open;
end;

function TC4DConnZeosQuery.Open(const ASQL: string): IC4DConnQuery;
begin
  Result := Self;
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(ASQL);
  Self.CriaCamposDaQuery;
  FQuery.Open;
end;

procedure TC4DConnZeosQuery.ProcessaListCond;
var
  i: Integer;
  LKey: string;
  LValue: Variant;
  LCond: string;
begin
  if(FListCond.Count <= 0)then
    Exit;

  LCond := '';
  for i := 0 to Pred(FListCond.Count)do
    LCond := LCond + FListCond.Strings[i] + sLineBreak;

  LCond := TC4DConnUtils.SQLConfBusca(LCond);
  FQuery.SQL.Add(LCond);

  for LKey in FListCondParam.Keys do
    if(FListCondParam.TryGetValue(LKey, LValue))then
      Self.AddParam(LKey, LValue);
end;

procedure TC4DConnZeosQuery.ProcessaListGroup;
var
  i: Integer;
  LGroup: string;
begin
  if(FListGroup.Count <= 0)then
    Exit;

  LGroup := '';
  for i := 0 to Pred(FListGroup.Count)do
    LGroup := LGroup + FListGroup.Strings[i].Trim + ', ';

  if(pos('group by', LGroup) <= 0)then
    LGroup := 'group by ' + LGroup;

  LGroup := LGroup.Trim;
  System.Delete(LGroup, Length(LGroup), 1);
  FQuery.SQL.Add(LGroup);
end;

procedure TC4DConnZeosQuery.ProcessaListOrder;
var
  i: Integer;
  LOrdem: string;
begin
  if(FListOrder.Count <= 0)then
    Exit;

  LOrdem := '';
  for i := 0 to Pred(FListOrder.Count)do
    LOrdem := LOrdem + FListOrder.Strings[i].Trim + ', ';

  if(pos('order by', LOrdem) <= 0)then
    LOrdem := 'order by ' + LOrdem;

  LOrdem := LOrdem.Trim;
  System.Delete(LOrdem, Length(LOrdem), 1);
  FQuery.SQL.Add(LOrdem);
end;

procedure TC4DConnZeosQuery.ProcessaListLimit;
var
  i: Integer;
begin
  for i := 0 to Pred(FListLimit.Count)do
    FQuery.SQL.Add(FListLimit.Strings[i]);
end;

procedure TC4DConnZeosQuery.CriaCamposDaQuery;
var
  i: Integer;
begin
  Exit;
  FQuery.FieldDefs.Update;
  for i := 0 to Pred(FQuery.FieldDefs.Count) do
    FQuery.FieldDefs[i].CreateField(FQuery);
end;

function TC4DConnZeosQuery.DataSet: TDataSet;
begin
  Result := FQuery;
end;

function TC4DConnZeosQuery.DataSource(Value: TDataSource): IC4DConnQuery;
begin
  Result := Self;
  Value.DataSet := FQuery;
end;

function TC4DConnZeosQuery.DataSourceMasterDetail(Value: TDataSource): IC4DConnQuery;
begin
  Result := Self;
  FQuery.DataSource := Value;
end;

function TC4DConnZeosQuery.Append: IC4DConnQuery;
begin
  Result := Self;
  FQuery.Append;
end;

function TC4DConnZeosQuery.Edit: IC4DConnQuery;
begin
  Result := Self;
  FQuery.Edit;
end;

function TC4DConnZeosQuery.Post: IC4DConnQuery;
begin
  Result := Self;
  FQuery.Post;
end;

function TC4DConnZeosQuery.Delete: IC4DConnQuery;
begin
  Result := Self;
  FQuery.Delete;
end;

function TC4DConnZeosQuery.Eof: Boolean;
begin
  Result := FQuery.Eof;
end;

function TC4DConnZeosQuery.Bof: Boolean;
begin
  Result := FQuery.Bof;
end;

function TC4DConnZeosQuery.Prior: IC4DConnQuery;
begin
  Result := Self;
  FQuery.Prior;
end;

function TC4DConnZeosQuery.Next: IC4DConnQuery;
begin
  Result := Self;
  FQuery.Next;
end;

function TC4DConnZeosQuery.First: IC4DConnQuery;
begin
  Result := Self;
  FQuery.First;
end;

function TC4DConnZeosQuery.Last: IC4DConnQuery;
begin
  Result := Self;
  FQuery.Last;
end;

function TC4DConnZeosQuery.IsEmpty: Boolean;
begin
  Result := FQuery.IsEmpty;
end;

function TC4DConnZeosQuery.RowsAffected: Integer;
begin
  Result := FQuery.RowsAffected
end;

function TC4DConnZeosQuery.SQL: TStrings;
begin
  Result := FQuery.SQL;
end;

function TC4DConnZeosQuery.FieldByName(Value: string): TField;
begin
  Result := FQuery.FieldByName(Value);
end;

function TC4DConnZeosQuery.RecNo: Integer;
begin
  Result := FQuery.RecNo;
end;

function TC4DConnZeosQuery.RecordCount: Integer;
begin
  Result := FQuery.RecordCount;
end;

function TC4DConnZeosQuery.RecordCountStr(ANumZerosLeft: Integer = 6): string;
begin
  Result := FQuery.RecordCount.ToString;
end;

//AName = PARA MYSQL E ZEOS NOME DA TABELA
function TC4DConnZeosQuery.GetLastAutoGenValue(const AName: string): Variant;
var
  LQuery: TZQuery;
begin
  LQuery := TZQuery.Create(nil);
  try
    try
      LQuery.Connection := FQuery.Connection;
      LQuery.Close;
      LQuery.SQL.Clear;
      LQuery.SQL.Add('Select Last_Insert_ID() as Last_Insert_ID from ' + AName);
      LQuery.Open;

      Result := LQuery.FieldByName('Last_Insert_ID').AsInteger;
      LQuery.Close;
    except
      on E: Exception do
        raise Exception.Create('Não foi possível recuperar o último código/id inserido no banco de dados: ' + E.Message);
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

end.
