defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    words = split_words sentence

    words
      |> Enum.uniq
      |> Enum.map(fn w -> { w, Enum.reduce(words, 0, count_occurences(w)) } end)
      |> Map.new
  end

  @spec split_words(String.t()) :: [String.t()]
  defp split_words(sentence) do
    sentence
      |> String.split([" ", "_"])
      |> Enum.map(fn word -> word |> String.downcase |> clean_word end)
      |> Enum.filter(fn word -> Regex.match?(~r/\w+/, word) end)

  end

  @spec count_occurences(String.t()) :: Integer.t()
  defp count_occurences(pattern) do
    fn word, acc -> if pattern === word, do: acc + 1, else: acc end
  end

  @spec clean_word(String.t()) :: String.t()
  defp clean_word(word), do: Regex.replace(~r/^.*?([\w-äöüÄÖÜß]+).*$/, word, "\\1")
end
