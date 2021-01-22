defmodule Models.Item do
  defstruct name: "", amount: 0, price: 0

  @type t(name, amount, price) :: %Models.Item{name: name, amount: amount, price: price}
  @type t :: %Models.Item{name: String.t(), amount: integer, price: integer}
end
