defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    words = split_words sentence
    uniques = words |> Enum.uniq |> Map.new(&({&1, 0}))

    Enum.reduce(words, uniques, &(count_reduce(&1, &2)))
  end

  @spec split_words(String.t()) :: [String.t()]
  defp split_words(sentence) do
    sentence
      |> String.downcase
      |> String.split(~r/_|[^\w-äöüÄÖÜß]+/, trim: true)
  end

  @spec count_reduce(String.t, map) :: map
  defp count_reduce(word, score), do: Map.update(score, word, 0, &(&1 + 1))
end
