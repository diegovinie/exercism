defmodule Bob do

  def hey(input) do
    cond do
      question?(input) and yelling?(input) ->
        "Calm down, I know what I'm doing!"
      question?(input)    -> "Sure."
      yelling?(input)     -> "Whoa, chill out!"
      say_nothing?(input) -> "Fine. Be that way!"
      true                -> "Whatever."
    end
  end

  defp question?(text), do: String.ends_with? text, "?"

  defp yelling?(text), do: letters?(text) and text == String.upcase(text)

  defp say_nothing?(text), do: "" == String.trim text

  defp letters?(text), do: !(String.upcase(text) == String.downcase(text))
end
