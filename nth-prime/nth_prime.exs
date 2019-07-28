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

  @spec prime?(pos_integer) :: boolean
  def prime?(2), do: true
  def prime?(num), do: not Enum.any? 2..(num - 1), &(rem(num, &1) == 0)

  @spec next(pos_integer) :: pos_integer
  def next(num), do: if prime?(num + 1), do: num + 1, else: next(num + 1)
end
