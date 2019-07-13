defmodule Bob do

  def hey(input) do
    cond do
      is_question(input) and is_yelling(input) ->
        "Calm down, I know what I'm doing!"
      is_question(input)  -> "Sure."
      is_yelling(input)   -> "Whoa, chill out!"
      say_nothing?(input) -> "Fine. Be that way!"
      true                -> "Whatever."
    end
  end

  defp is_question(text), do: String.ends_with? text, "?"

  defp is_yelling(text), do: letters?(text) and text === String.upcase(text)

  defp say_nothing?(text), do: "" === String.trim text

  defp letters?(text), do: !(String.upcase(text) === String.downcase(text))
end
