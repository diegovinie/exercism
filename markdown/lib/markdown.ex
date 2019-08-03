defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown_text) do
    markdown_text
    |> String.split("\n")
    |> Enum.map(&process/1)
    |> Enum.join
    |> patch
  end

  @spec process(String.t()) :: String.t()
  defp process("*" <> _ = text), do: parse_list_md_level(text)
  defp process("#" <> _ = text) do
    text
    |> parse_header_md_level
    |> enclose_with_header_tag
  end
  defp process(text) do
    text
    |> String.split
    |> enclose_with_paragraph_tag
  end

  @spec parse_header_md_level(String.t()) :: {integer, String.t()}
  defp parse_header_md_level(hashes_and_text) do
    [[_, hashes, text]] = Regex.scan(~r/^(#+) (.*)$/, hashes_and_text)

    {String.length(hashes), text}
  end

  @spec parse_list_md_level(String.t()) :: String.t()
  defp parse_list_md_level(line) do
    text = line
    |> String.trim_leading("* ")
    |> String.split
    |> join_words_with_tags

    "<li>#{ text }</li>"
  end

  @spec enclose_with_header_tag({integer, String.t()}) :: String.t()
  defp enclose_with_header_tag({level, text}) do
    "<h#{ level }>#{ text }</h#{ level }>"
  end

  @spec enclose_with_paragraph_tag(String.t()) :: String.t()
  defp enclose_with_paragraph_tag(text) do
    string = join_words_with_tags(text)

    "<p>#{string}</p>"
  end

  @spec join_words_with_tags(String.t()) :: String.t()
  defp join_words_with_tags(text) do
    text
    |> Enum.map(&replace_md_with_tag/1)
    |> Enum.join(" ")
  end

  @spec replace_md_with_tag(String.t()) :: String.t()
  defp replace_md_with_tag(word) do
    word
    |> replace_prefix_md
    |> replace_suffix_md
  end

  @spec replace_prefix_md(String.t()) :: String.t()
  defp replace_prefix_md(word) do
    word
    |> String.replace(~r/^__{1}/, "<strong>", global: false)
    |> String.replace(~r/^([_{1}])([^_+])/, "<em>\\2", global: false)
  end

  @spec replace_suffix_md(String.t()) :: String.t()
  defp replace_suffix_md(word) do
    word
    |> String.replace(~r/__{1}$/, "</strong>")
    |> String.replace(~r/_/, "</em>")
  end

  @spec patch(String.t()) :: String.t()
  defp patch(list) do
    list
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
