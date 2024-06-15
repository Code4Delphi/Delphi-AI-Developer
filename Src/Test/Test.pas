unit Test;

interface

uses
  SysUtils, Classes;

type
  // Classe Cliente
  TCliente = class
  private
    FId: Integer;
    FNome: String;
    FTelefone: String;
    FCidade: String;
  public
    // Propriedades
    property Id: Integer read FId write FId;
    property Nome: String read FNome write FNome;
    property Telefone: String read FTelefone write FTelefone;
    property Cidade: String read FCidade write FCidade;

    // Construtor
    constructor Create(const AId: Integer; const ANome: String; const ATelefone: String; const ACidade: String);
  end;

implementation

// Construtor da classe Cliente
constructor TCliente.Create(const AId: Integer; const ANome: String; const ATelefone: String; const ACidade: String);
begin
  FId := AId;
  FNome := ANome;
  FTelefone := ATelefone;
  FCidade := ACidade;
end;

end.
