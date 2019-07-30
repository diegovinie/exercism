defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
    count(count)
  end

  @spec count(integer, pos_integer) :: pos_integer
  def count(num, prime \\ 1)
  def count(0, prime), do: prime
  def count(num, prime), do: count(num - 1, next(prime))

  # from screamingjungle's solution
  def prime?(2), do: true
  def prime?(n) when n < 2 or rem(n, 2) == 0, do: false
  def prime?(n), do: prime?(n, 3)
  defp prime?(n, k) when n < k*k, do: true
  defp prime?(n, k) when rem(n, k) == 0, do: false
  defp prime?(n, k), do: prime?(n, k + 2)

  @spec next(pos_integer) :: pos_integer
  def next(num), do: if prime?(num + 1), do: num + 1, else: next(num + 1)
end
