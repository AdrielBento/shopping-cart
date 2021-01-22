defmodule Services.ShoppingCartService do
  alias Models.Item

  @spec divides_purchase_amount(%{emails: [String.t()], shopping_list: [Item.t()]}) ::
          {:ok, map}
  def divides_purchase_amount(%{emails: emails, shopping_list: items}) do
    items
    |> sum_items_value()
    |> divide_billing_by_email(emails)
    |> create_billing_list(emails)
  end

  @spec divide_billing_by_email(integer, [String.t()]) :: [integer, ...]
  def divide_billing_by_email(amount, emails) when length(emails) > 0 do
    amount_per_email = div(amount, length(emails))
    diff = amount - trunc(amount_per_email * length(emails))

    cond do
      diff == 0 ->
        List.duplicate(amount_per_email, length(emails))

      true ->
        List.duplicate(amount_per_email, length(emails) - 1) ++ [diff + amount_per_email]
    end
  end

  def divide_billing_by_email(_amount, _emails), do: []

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
