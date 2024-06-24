unit C4D.Conn.Interfaces;

interface

uses
  Data.DB,
  System.Classes,
  C4D.Conn.Configs;

type
  IC4DConnection = interface
    ['{F76544A9-F17F-4220-8C9E-A99D3A1A9DEC}']
    function Component: TComponent;
    function Open: IC4DConnection;
    function Close: IC4DConnection;
    function StartTransaction: IC4DConnection;
    function Commit: IC4DConnection;
    function Rollback: IC4DConnection;

    function TestConnection: Boolean;
    function TestConnectionOnly: Boolean;
    function LoadConnectionConfig: IC4DConnection;
  end;

  IC4DConnQuery = interface
    ['{9F8958BA-2128-4D47-B2F5-F42B449B0E3C}']
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
    function DataSource(Valeu: TDataSource): IC4DConnQuery;
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
    function RecordCountStr(pNumZerosLeft: Integer = 6): string;

    //AName = PARA MYSQL E ZEOS NOME DA TABELA
    //AName = PARA MYSQL E FIREDAC NOME DO CAMPO
    function GetLastAutoGenValue(const AName: string): Variant;
  end;

  IC4DConn = interface
    ['{0940FDA5-86DA-495A-B3A9-949869639B3F}']
    function Configs: TC4DConnConfigs;
    function Connection: IC4DConnection;
    function Query: IC4DConnQuery; overload;
    function Query(aNameQuery: string): IC4DConnQuery; overload;
  end;

implementation

end.
