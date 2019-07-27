defmodule CollatzConjecture do

  defguard is_odd(num) when is_integer(num) and rem(num, 2) == 0
  defguard is_even(num) when is_integer(num) and rem(num, 2) != 0

  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when input > 0, do: count(input, 0)
  def calc(_), do: raise FunctionClauseError

  def count(1, acc), do: acc
  def count(num, acc), do: count(analize(num), acc + 1)

  def analize(num) when is_odd(num), do: div(num, 2)
  def analize(num) when is_even(num), do: num * 3 + 1
end
