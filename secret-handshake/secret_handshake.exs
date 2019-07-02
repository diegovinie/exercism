defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    translate_handshakes(code) |> check_reverse(code)
  end

  @spec translate_handshakes(code :: integer) :: list(String.t())
  defp translate_handshakes(code) do
    %{
      0b1 => "wink",
      0b10 => "double blink",
      0b100 => "close your eyes",
      0b1000 => "jump"
    } |> Enum.map(fn ({k, v}) -> if (k &&& code) > 0, do: v, else: nil end)
      |> Enum.filter(&(&1))
  end

  @spec check_reverse(items :: list(String.t()), code :: integer) :: list(String.t())
  defp check_reverse(items, code) do
    if (10000 &&& code) > 0, do: Enum.reverse(items), else: items
  end
end
