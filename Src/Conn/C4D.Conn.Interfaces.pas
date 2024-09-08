unit C4D.Conn.Interfaces;

interface

uses
  Data.DB,
  System.Classes,
  C4D.Conn.Configs;

type
  IC4DConnection = interface
    ['{5B72EBFB-CE76-42F6-B716-226E5149F572}']
    function Component: TComponent;
    function Open: IC4DConnection;
    function Close: IC4DConnection;
    function StartTransaction: IC4DConnection;
    function Commit: IC4DConnection;
    function Rollback: IC4DConnection;

    function TestConnection: Boolean;
    function LoadConnectionConfig: IC4DConnection;
  end;

  IC4DConnQuery = interface
    ['{8C098AA7-288F-4458-AFDB-E44CC95E5441}']
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
    function RecordCountStr(ANumZerosLeft: Integer = 6): string;
    function IndexFieldNames: string; overload;
    function IndexFieldNames(Value: string): IC4DConnQuery; overload;

    //AName = PARA MYSQL E ZEOS NOME DA TABELA
    //AName = PARA MYSQL E FIREDAC NOME DO CAMPO
    function GetLastAutoGenValue(const AName: string): Variant;
  end;

  IC4DConn = interface
    ['{71342615-E414-4D66-9280-67218D5FB27A}']
    function Configs: TC4DConnConfigs;
    function Connection: IC4DConnection;
    function Query: IC4DConnQuery; overload;
    function Query(const ANameQuery: string): IC4DConnQuery; overload;
  end;

implementation

end.
