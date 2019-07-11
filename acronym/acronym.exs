defmodule Acronym do

  @re ~r/[[:upper:]]?[[:lower:]]+/

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    split_words(string)
    |> Enum.map(&get_initial/1)
    |> Enum.join
    |> String.upcase
  end

  @spec split_words(String.t) :: [String.t]
  defp split_words(string), do: Regex.scan(@re, string) |> List.flatten

  @spec get_initial(String.t) :: String.t
  defp get_initial(word) do
    String.to_charlist(word) |> (fn [initial | _] -> [initial] end).()
  end
end
