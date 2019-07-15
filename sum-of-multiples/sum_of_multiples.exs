defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.map(&find_multiples(&1, limit))
    |> Enum.reduce([], &(&1 ++ &2))
    |> Enum.uniq
    |> Enum.sum
  end

  @spec find_multiples(non_neg_integer, non_neg_integer) :: [non_neg_integer]
  defp find_multiples(factor, limit) when limit <= factor, do: []
  defp find_multiples(factor, limit) when limit > factor do
    for x <- factor..(limit - 1), rem(x, factor) == 0, do: x
  end
end
