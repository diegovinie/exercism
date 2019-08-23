defmodule OcrNumbers do
  @error_colums {:error, 'invalid column count'}

  @error_line {:error, 'invalid line count'}

  @numbers [
    {"0", [ " _ ",
            "| |",
            "|_|",
            "   "]},
    {"1", [ "   ",
            "  |",
            "  |",
            "   "]},
    {"2", [ " _ ",
            " _|",
            "|_ ",
            "   "]},
    {"3", [ " _ ",
            " _|",
            " _|",
            "   "]},
    {"4",  ["   ",
            "|_|",
            "  |",
            "   "]},
    {"5", [ " _ ",
            "|_ ",
            " _|",
            "   "]},
    {"6", [ " _ ",
            "|_ ",
            "|_|",
            "   "]},
    {"7", [ " _ ",
            "  |",
            "  |",
            "   "]},
    {"8", [ " _ ",
            "|_|",
            "|_|",
            "   "]},
    {"9", [ " _ ",
            "|_|",
            " _|",
            "   "]}
  ]

  defguard is_lines_correct(input) when rem(length(input), 4) == 0

  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t()]) :: {:ok | :error, String.t()}
  def convert(input) when not is_lines_correct(input), do: @error_line
  def convert(input) do
    case correct_columns?(input) do
      true  ->
        num = input
        |> Enum.chunk_every(4)
        |> Enum.map_join(",", &parse_group/1)
        {:ok, num}
      false ->
        @error_colums
    end
  end

  @spec parse_line([String.t()]) :: String.t()
  def parse_line(line) do
    case Enum.find(@numbers, fn {_, v} -> v == line end) do
      {num, _}  -> num
      nil       -> "?"
    end
  end

  @spec parse_group([String.t()]) :: [String.t()]
  def parse_group(group) do
    group
    |> spread_digits
    |> Enum.map_join("", &parse_line/1)
  end

  @spec correct_columns?([String.t()]) :: boolean
  def correct_columns?(input) do
    Enum.all?(input, &(rem(String.length(&1), 3) == 0))
  end

  @spec spread_digits([String.t()]) :: [String.t()]
  def spread_digits(input) do
    input
    |> Enum.map(fn line -> Regex.scan(~r/.{3}/, line) |> Enum.concat end)
    |> Enum.zip
    |> Enum.map(&Tuple.to_list/1)
  end
end
