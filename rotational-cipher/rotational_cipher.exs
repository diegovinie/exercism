defmodule RotationalCipher do
  @lowercased Enum.to_list ?a..?z
  @uppercased Enum.to_list ?A..?Z

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    to_charlist(text)
    |> Enum.map(&shift_letter(&1, shift))
    |> to_string
  end

  def shift_letter(char, shift) when char in @lowercased do
    in_cycle(@lowercased, char + shift)
  end
  def shift_letter(char, shift) when char in @uppercased do
    in_cycle(@uppercased, char + shift)
  end
  def shift_letter(char, _), do: char

  def in_cycle(list, shift) do
    Stream.cycle(list) |> Enum.at(shift - List.first(list))
  end
end
