defmodule Services.ShoppingCartServiceTest do
  use ExUnit.Case

  alias Services.ShoppingCartService
  alias Models.Item

  setup [:emails_data_provider]

  defp emails_data_provider(_context) do
    [
      emails: ["cursores@gmail.com", "rustixir@hotmail.com.br", "jav@alguma.com.br"]
    ]
  end

  test "Must return the amounts to be paid with unequal division", context do
    assert [33, 33, 34] = ShoppingCartService.divide_billing_by_email(100, context[:emails])
  end

  test "Must return the amounts to be paid with equal division", context do
    assert [50, 50, 50] = ShoppingCartService.divide_billing_by_email(150, context[:emails])
  end

  test "Should return an empty billing list when it has no items" do
    assert {:ok, %{}} =
             ShoppingCartService.divides_purchase_amount(%{emails: [], shopping_list: []})
  end

  test "Should return a billing list", context do
    shopping_list = [
      %Item{
        name: "Teclado hyperX",
        amount: 1,
        price: 5000
      },
      %Item{
        name: "Mouse hyperX",
        amount: 1,
        price: 5000
      }
    ]

    assert {:ok,
            %{
              "cursores@gmail.com" => 3333,
              "jav@alguma.com.br" => 3334,
              "rustixir@hotmail.com.br" => 3333
            }} =
             ShoppingCartService.divides_purchase_amount(%{
               emails: context[:emails],
               shopping_list: shopping_list
             })
  end
end
