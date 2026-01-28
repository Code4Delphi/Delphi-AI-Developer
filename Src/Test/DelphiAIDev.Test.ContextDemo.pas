unit DelphiAIDev.Test.ContextDemo;

interface

uses
  System.SysUtils;

type
  // Classe de exemplo para testar o Contexto Global da IA
  TShoppingCartItem = class
  private
    FItemName: string;
    FQuantity: Integer;
    FPrice: Currency;
    FDiscount: Currency;
    FTotal: Currency;
    procedure SetTotal(const Value: Currency);
  public
    // A IA deve ser capaz de ler estas propriedades na interface
    // mesmo que o cursor esteja lá embaixo na implementação.
    property ItemName: string read FItemName write FItemName;
    property Quantity: Integer read FQuantity write FQuantity;
    property Price: Currency read FPrice write FPrice;
    property Discount: Currency read FDiscount write FDiscount;
    property Total: Currency read FTotal write SetTotal;

// Descomente a linha abaixo antes do teste, parao Delphi não reclamar..
//    procedure CalculateFinalPrice;
  end;

implementation

{ TShoppingCartItem }

procedure TShoppingCartItem.SetTotal(const Value: Currency);
begin
  FTotal := Value;
end;

// -----------------------------------------------------------------------------
// CASO DE TESTE:
// Posicione o cursor na linha abaixo e acione o Code Completion (Alt+Enter padrão)
// Tente algo como: "Implemente o metodo CalculateFinalPrice considerando desconto"
// -----------------------------------------------------------------------------

// << PONTO DE TESTE AQUI >>

end.
