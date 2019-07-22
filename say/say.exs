defmodule Say do

  @initials %{
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
  }

  @decs %{
    2 => "twenty",
    3 => "thirty",
    4 => "forty",
    5 => "fifty",
    6 => "sixty",
    7 => "seventy",
    8 => "eighty",
    9 => "ninthy"
  }

  @triads %{
    1 => "",
    2 => " thousand",
    3 => " million",
    4 => " billion"
  }

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number < 0 or number >= 1_000_000_000_000, do:
    {:error, "number is out of range"}
  def in_english(number) do
    {:ok, analize(number)}
  end

  def analize(0), do: "zero"
  def analize(num) do
    triads = spread(num)

    Enum.zip(triads, 1..length(triads))
    |> Enum.filter(&(&1 > 0))
    |> Enum.reverse
    |> Enum.map(fn
      {0, _}    -> nil
      {tri, g}  -> triad(tri) <> @triads[g]
    end)
    |> Enum.filter(&(&1))
    |> Enum.join(" ")
  end

  @spec spread(non_neg_integer) :: [[pos_integer]]
  def spread(0), do: []
  def spread(num), do: [rem(num, 1000) | spread(div(num, 1000))]

  @spec triad(non_neg_integer) :: String.t()
  def triad(0), do: nil
  def triad(num) when num < 100, do: decs(num)
  def triad(num) do
    case {div(num, 100), rem(num, 100)} do
      {fs, 0}     -> "#{@initials[fs]} hundred"
      {fs, decs}  -> "#{@initials[fs]} hundred #{decs(decs)}"
    end
  end

  @spec decs(non_neg_integer) :: String.t()
  def decs(num) when num < 20, do: @initials[num]
  def decs(num) do
    Integer.digits(num)
    |> Enum.zip([2, 1])
    |> Enum.map(&translate_digits/1)
    |> Enum.filter(&(&1))
    |> Enum.join("-")
  end

  def translate_digits({0, _pos}), do: nil
  def translate_digits({digit, 1}), do: @initials[digit]
  def translate_digits({digit, 2}), do: @decs[digit]
end
