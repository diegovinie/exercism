defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  defp dna_rna_eq, do: %{
    "A" => "U",
    "C" => "G",
    "T" => "A",
    "G" => "C"
  }

  @spec to_rna([char]) :: [char]
  def to_rna(dna), do: dna
    |> List.to_string
    |> String.codepoints
    |> Enum.map(fn code -> dna_rna_eq[code] end)
    |> List.to_charlist

end
