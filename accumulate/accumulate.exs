defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list
  def accumulate(list, fun) do
    map(list, fun)
  end

  # solution with coprehension lists, sugar for map, filter, reduce
  # def accumulate(list, fun), do: for n <- list, do: fun.(n)

  defp map([], _fun), do: []
  defp map([head | tail], fun), do: [fun.(head) | map(tail, fun)]
end
