defmodule RunLengthEncoder do
  import String, only: [duplicate: 2, to_integer: 1]
  import Enum, only: [map: 2, map_join: 3, chunk_by: 2, count: 1]

  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    to_charlist(string)
    |> chunk_by(&(&1))
    |> map(fn(chars) -> {List.first(chars), count(chars)} end)
    |> map_join("", fn
      {char, 1}   -> <<char>>
      {char, num} -> "#{num}#{<<char>>}"
    end)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(~r/(\d+)?([\w ])/, string)
    |> map_join("", &expand/1)
  end

  defp expand([_, "", char]), do: char
  defp expand([_, num, char]), do: duplicate(char, to_integer(num))
end
