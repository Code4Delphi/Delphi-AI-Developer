unit C4D.Conn.Utils;

interface

uses
  System.SysUtils,
  System.StrUtils;

type
  TC4DConnUtils = class
  public
    class function SQLConfBusca(ASql: string): string;
    class function SQLTratar(ASql: string): string;
  end;

implementation

class function TC4DConnUtils.SQLConfBusca(ASql: string): string;
begin
  Result := ASql.Trim;

  if(Result.IsEmpty)then
    Exit;

  if(copy(Result, 1, 3) = 'and')then
  begin
    Delete(Result, 1, 3);
    Result := 'where '+ Result;
  end
  else if(copy(Result, 1, 2) = 'or')then
  begin
    Delete(Result, 1, 2);
    Result := 'where '+ Result;
  end
  else if(copy(Result, 1, 5) <> 'where')
    and(copy(Result, 1, 5) <> 'limit')
    and(copy(Result, 1, 8) <> 'order by')
    and(copy(Result, 1, 8) <> 'group by')
  then
  begin
    Result := 'where '+ Result;
  end;

  Result := Self.SQLTratar(Result) + ' ';
end;

class function TC4DConnUtils.SQLTratar(ASql: string): string;
begin
  Result := ASql;
  Result := StringReplace(Result, ' ALTER ', ' ALTERA ', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'ALTER TABLE', 'ALTERA TABLE', [rfReplaceAll, rfIgnoreCase]);

  Result := StringReplace(Result, ' DROP ', ' DROPE ', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'DROP TABLE', 'DROPE TABLE', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'DROP PROCEDURE', 'DROPE PROCEDURE', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'DROP FUNCTION', 'DROPE FUNCTION', [rfReplaceAll, rfIgnoreCase]);
end;

end.
