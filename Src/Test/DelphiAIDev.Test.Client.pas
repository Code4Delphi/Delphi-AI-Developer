unit DelphiAIDev.Test.Client;

interface

type
  TDelphiAIDevTestClient = class
  private
    FNome: string;
    FCPF: string;
    FEndereco: string;
    FIdade: Integer;
  public
    constructor Create(ANome: string; ACpf: string; AEndereco: string);
    property Nome: string read FNome write FNome;
    property CPF: string read FCPF write FCPF;
    property Endereco: string read FEndereco write FEndereco;
    property Idade: Integer read FIdade write FIdade;
    procedure LimparVariaveis;
  end;

implementation


{ TDelphiAIDevTestClient }

constructor TDelphiAIDevTestClient.Create(ANome, ACpf, AEndereco: string);
begin

end;

procedure TDelphiAIDevTestClient.LimparVariaveis;
begin
  FNome := '';
  FCPF := '';
  FEndereco := '';
  FIdade := 0;
end;

end.
