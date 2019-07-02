defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna_rna_eq = %{
      ?A => ?U,
      ?C => ?G,
      ?T => ?A,
      ?G => ?C
    }

    Enum.map dna, fn code -> dna_rna_eq[code] end
  end
end
