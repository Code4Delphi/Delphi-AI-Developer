unit DelphiAIDev.Test;

interface

type
  TDelphiAIDevTest = class
  private
    FCodigo: Integer;
    FNome: string;
    FIdade: Integer;
    procedure Clear;
  public
  end;

implementation

procedure TDelphiAIDevTest.Clear;
begin
  FCodigo := 0;

end;

end.
