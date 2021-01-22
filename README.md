# 🛒 Programa de Formação em Elixir | Teste Técnico

### [📃 Proposta](https://gist.github.com/programa-elixir/1bd50a6d97909f2daa5809c7bb5b9a8a)

### 🏃🏾‍♂️ Instruções

**1. Instalar as dependências do projeto**

```bash
> mix deps.get
```

**2. Compilar o projeto e rodar os testes**

```bash
> mix compile && mix test
```

**3. Adicionar os dados de testes**

Os dados para a validação devêm ser inseridos no arquivo **payload.json**, na pasta files.

```json
{
  "emails": [
    "cursores@gmail.com",
    "rustixir@hotmail.com.br",
    "jav@alguma.com.br"
  ],
  "shopping_list": [
    {
      "name": "Teclado hyperX",
      "amount": 1,
      "price": 25000
    },
    {
      "name": "Mouse hyperX",
      "amount": 1,
      "price": 25000
    }
  ]
}
```

**4. Executando o projeto**

Para executar o projeto basta abrir o **Interactive Shell** do Elixir e rodar o comando **ShoppingCart.main**. Exemplo:

```bash
> iex -S mix
Interactive Elixir (1.11.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> ShoppingCart.main
{:ok,
 %{
   "cursores@gmail.com" => 4166,
   "hah44a@alguma.com.br" => 4166,
   "jav@alguma.com.br" => 4166,
 }}
```

---

### 🏭 Detalhes

- 🧪 Utilizei o TDD desenvolver a solução do teste
- Tentei utilizar `ExUnit.Parameterized`, mas acabei descartando dado problemas de no uso da API da macro.
  - **Objetivo:** Criar data providers para testar com diferentes inputs/outputs um mesmo test.
- Preferi utilizar mais o Pattern Matching e o Guards para fazer algumas validações em vez de utilizar um `if` ou `unless` em um `easy return`
