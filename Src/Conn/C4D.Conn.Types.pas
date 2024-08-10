unit C4D.Conn.Types;

interface

type
  {$SCOPEDENUMS ON}
  TComponentConnection = (Empty, FireDac {$IFDEF C4D_ZEOS}, Zeos {$ENDIF});
  {$SCOPEDENUMS OFF}

implementation

end.
