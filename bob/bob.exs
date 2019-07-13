defmodule Bob do
  @matchers %{
    is_question: ~r/\?$/,
    is_russian_yelling: ~r/^[[:upper:]]+$/u,
    is_yelling: ~r/^[^:lower:]{3,}$/,
    no_letters: ~r/^[^A-Za-z]*$/,
    spaces: ~r/^\s*$/
  }
  def hey(input) do
    cond do
      check(input, :spaces) ->
        "Fine. Be that way!"
      check(input, :is_question) and check(input, :is_yelling) ->
        "Calm down, I know what I'm doing!"
      check(input, :is_question) ->
        "Sure."
      check(input, :is_russian_yelling) ->
        "Whoa, chill out!"
      check(input, :no_letters) ->
        "Whatever."
      check(input, :is_yelling)
      -> "Whoa, chill out!"
      true
      -> "Whatever."
    end
  end

  def check(text, condition) do
    String.match?(text, Map.get(@matchers, condition))
  end
end
