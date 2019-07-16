defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    sides = [a, b, c]
    cond do
      !all_positives?(sides) -> {:error, "all side lengths must be positive"}
      !area?(sides) -> {:error, "side lengths violate triangle inequality"}
      true -> case length Enum.uniq(sides) do
        1 -> {:ok, :equilateral}
        2 -> {:ok, :isosceles}
        3 -> {:ok, :scalene}
      end
    end
  end

  @spec all_positives?([number]) :: boolean
  defp all_positives?(sides), do: Enum.all?(sides, &(&1 > 0))

  @spec area?([number]) :: boolean
  defp area?(sides) do
    [major | minors] = Enum.sort(sides, &(&1 >= &2))
    major < Enum.sum minors
  end
end
