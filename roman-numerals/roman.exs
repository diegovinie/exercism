defmodule Roman do
  @type group :: :units | :decs | :cents | :mils

  @roman_set %{
    units: %{uni: "I", qui: "V", dec: "X"},
    decs: %{uni: "X", qui: "L", dec: "C"},
    cents: %{uni: "C", qui: "D", dec: "M"},
    mils: %{uni: "M"}
  }

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    spread_integer(number)
    |> Enum.zip([:units, :decs, :cents, :mils])
    |> Enum.map(&parse_digit/1)
    |> Enum.reverse
    |> Enum.join
  end

  @spec spread_integer(integer) :: [integer]
  defp spread_integer(num) do
    base = trunc(num / 10)
    rec = rem(num, 10)

    [ rec | (if base > 0, do: spread_integer(base), else: []) ]
  end

  @spec parse_digit({pos_integer, group}) :: String.t
  defp parse_digit({digit, group}) do
    set = @roman_set[group]

    cond do
      digit == 0 -> ""
      digit == 4 -> set[:uni] <> set[:qui]
      digit == 9 -> set[:uni] <> set[:dec]
      digit == 5 -> set[:qui]
      digit < 4  -> String.duplicate set[:uni], digit
      digit > 5  -> set[:qui] <> String.duplicate set[:uni], digit - 5
    end
  end
end
