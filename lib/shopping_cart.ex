defmodule ShoppingCart do
  @base_path ".\\files\\payload.json"

  @spec main :: any
  def main do
    {:ok, content} = @base_path |> Path.expand() |> File.read()

    Jason.decode!(content, [{:keys, :atoms}])
    |> Services.ShoppingCartService.divides_purchase_amount()
  end
end
