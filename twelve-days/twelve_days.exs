defmodule TwelveDays do
  @replacers [
    {"first", "a Partridge in a Pear Tree"},
    {"second", "two Turtle Doves"},
    {"third", "three French Hens"},
    {"fourth", "four Calling Birds"},
    {"fifth", "five Gold Rings"},
    {"sixth", "six Geese-a-Laying"},
    {"seventh", "seven Swans-a-Swimming"},
    {"eighth", "eight Maids-a-Milking"},
    {"ninth", "nine Ladies Dancing"},
    {"tenth", "ten Lords-a-Leaping"},
    {"eleventh", "eleven Pipers Piping"},
    {"twelfth", "twelve Drummers Drumming"}
  ]

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "On the #{get_day(number)} day of Christmas my true love gave to me: #{make_gifts(number)}."
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    Enum.map(starting_verse..ending_verse, &verse(&1))
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, length @replacers)
  end

  @spec make_gifts(pos_integer) :: String.t
  defp make_gifts(1), do: Enum.at(@replacers, 0) |> elem(1)
  defp make_gifts(line) do
    [first | lasts] = Enum.zip(@replacers, 1..line)

    Enum.map(lasts, fn {{_day, gift},_line} -> gift end)
    |> Enum.reverse
    |> Enum.join(", ")
    |> (fn str -> str <> ", and " <> elem(elem(first, 0), 1) end).()
  end

  @spec get_day(pos_integer) :: String.t
  defp get_day(line), do: Enum.at(@replacers, line - 1) |> elem(0)
end
