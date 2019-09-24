defmodule ProteinTranslation do
  @codons %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }
  @doc """
  Given an "RNA" string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    chain = rna
      |> to_charlist
      |> Enum.chunk_every(3)
      |> Enum.map(&(&1 |> to_string |> of_codon))
      |> Enum.take_while(&check_stop/1)

    case Enum.any?(chain, &check_rna_error/1) do
      true  -> {:error, "invalid RNA"}
      false -> {:ok, Enum.map(chain, fn {_, protein} -> protein end)}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case @codons[codon] do
      nil     -> {:error, "invalid codon"}
      protein -> {:ok, protein}
    end
  end

  @spec check_stop({any, String.t()}) :: boolean
  defp check_stop({_, status}), do: status != "STOP"

  @spec check_rna_error({:atom, any}) :: boolean
  defp check_rna_error({status, _}), do: status == :error
end
