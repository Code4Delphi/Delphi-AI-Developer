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
    FEmail: string;
    FSalario: Double;
  public
    property Nome: string read FNome write FNome;
    property Endereco: string read FEndereco write FEndereco;
    property Bairro: string read FBairro write FBairro;
    property Numero: Integer read FNumero write FNumero;
    property Telefone: string read FTelefone write FTelefone;
    property Email: string read FEmail write FEmail;
    property Salario: Double read FSalario write FSalario;
  end;

implementation


end.
