# Guia de Teste: Code Completion com Contexto Global

Este guia explica como validar a feature `feature/contexto-global`.

## O Cenário

Criamos uma unit de exemplo em `Src/Test/DelphiAIDev.Test.ContextDemo.pas`. Ela possui uma classe `TShoppingCartItem` definida na `interface`, com campos privados (`FQuantity`, `FPrice`, `FDiscount`, `FTotal`).

## Como Testar

1. Abra o arquivo `Src/Test/DelphiAIDev.Test.ContextDemo.pas` no Delphi.
2. Vá para a seção `implementation`, onde diz `// << PONTO DE TESTE AQUI >>`.
3. Digite o seguinte comentário ou apenas posicione o cursor e abra o chat/completion:

   ```delphi
   // Implemente o procedure CalculateFinalPrice
   ```

4. Acione o atalho do **Code Completion** (Padrão: `Alt + Enter` ou conforme sua config).

## Comparativo de Resultados

### ❌ Antes (Sem Contexto)

A IA recebia apenas a linha onde estava o cursor ou o texto selecionado.

* **Provável Resposta**: A IA criaria um código genérico ou inventaria variáveis, pois não sabia que `FPrice` ou `FQuantity` existiam.

    ```delphi
    procedure TShoppingCartItem.CalculateFinalPrice;
    begin
      // A IA não sabe quais variáveis usar
      // Pode inventar algo como: Result := A * B;
    end;
    ```

### ✅ Agora (Com Feature Ativa)

A IA recebe todo o código entre `unit` e `implementation`.

* **Resultado Esperado**: A IA deve reconhecer os campos da classe e montar a lógica correta.

    ```delphi
    procedure TShoppingCartItem.CalculateFinalPrice;
    begin
      // A IA sabe que FTotal, FQuantity, FPrice e FDiscount existem!
      FTotal := (FQuantity * FPrice) - FDiscount;
    end;
    ```

## Dica Extra

Experimente adicionar um `uses System.Math;` na interface e pedir para usar uma função matemática. A IA deverá saber que a unit já foi declarada e não sugerir adicioná-la novamente de forma redundante.
