unit DelphiAIDev.Test.Client;

interface

type
  TDelphiAIDevTestClient = class
  private
    FNome: string;
    FEndereco: string;
    FBairro: string;
    FNumero: Integer;
    FTelefone: string;
  public
    property Nome: string read FNome write FNome;
    property Endereco: string read FEndereco write FEndereco;
    property Bairro: string read FBairro write FBairro;
    property Numero: Integer read FNumero write FNumero;
    property Telefone: string read FTelefone write FTelefone;

    procedure Clear;
  end;

implementation

procedure TDelphiAIDevTestClient.Clear;
begin
  FNome := '';
  FEndereco := '';
  FBairro := '';
  FNumero := 0;
  FTelefone := '';
end;

end.
