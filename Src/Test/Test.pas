unit Test;

interface

uses
  System.SysUtils,System.StrUtils,      System.Classes;

type
  TCliente =        class
  private
    FId: Integer;
  FNome: String;
      FTelefone:       String;
    FCidade: String;
  public
  property Id: Integer      read FId        write     FId;
    property Nome: String     read FNome write FNome;
  property Telefone: String read     FTelefone write FTelefone;
   property Cidade: String   read FCidade write FCidade;
     constructor Create(const    AId: Integer; const ANome: String; const ATelefone: String; const ACidade: String);
  end;

implementation

constructor TCliente.Create( const AId  : Integer; const ANome : String; const ATelefone: String; const ACidade: String);
begin
  FId := AId;
    FNome := ANome;
   FTelefone := ATelefone;
  FCidade := ACidade;
end;

end.
