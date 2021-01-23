defmodule Services.ShoppingCartService do
  alias Models.Item

  @spec divides_purchase_amount(%{emails: [String.t()], shopping_list: [Item.t()]}) ::
          {:ok, map}
  def divides_purchase_amount(%{emails: emails, shopping_list: items}) do
    items
    |> sum_items_value()
    |> divide_billing_by_email(length(emails))
    |> create_billing_list(emails)
  end

  @spec divide_billing_by_email(integer, integer) :: [integer, ...]
  def divide_billing_by_email(amount, length_email) when length_email > 0 do
    amount_per_email = div(amount, length_email)
    diff = amount - trunc(amount_per_email * length_email)

    cond do
      diff == 0 ->
        List.duplicate(amount_per_email, length_email)

      true ->
        rest = divide_rest_equally(diff, length_email, amount_per_email)
        List.duplicate(amount_per_email, length_email - length(rest)) ++ rest
    end
  end

  def divide_billing_by_email(_amount, _emails), do: []

  @spec divide_rest_equally(any, integer, integer) :: [[any]]
  def divide_rest_equally(diff, length_email, amount_per_email) do
    Enum.filter(length_email..2, fn x -> div(diff, x) > 0 end)
    |> List.first()
    |> divide_rest(diff, amount_per_email)
  end

  @spec divide_rest(integer, integer, integer) :: [list]
  def divide_rest(divider, diff, amount_per_email) when not is_nil(divider) do
    (div(diff, divider) + amount_per_email)
    |> List.duplicate(divider)
  end

  def divide_rest(_divider, diff, amount_per_email), do: [amount_per_email + diff]

  @spec sum_items_value([Item.t()]) :: integer
  defp sum_items_value(items) do
    Enum.map(items, fn item -> item.price * item.amount end)
    |> Enum.sum()
  end

  @spec create_billing_list([integer], [String.t()]) :: {:ok, map}
  defp create_billing_list(values, emails) do
    billing =
      for {email, key} <- Enum.with_index(emails), into: %{}, do: {email, Enum.at(values, key)}

    {:ok, billing}
  end
end
