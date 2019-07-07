defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean), list(any)) :: list(any)
  def keep(list, fun, acc \\ [])
  def keep([], _fun, acc), do: acc
  def keep([h | tail], fun, acc), do: keep(tail, fun, concat_if(h, fun, acc))

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun), do: keep(list, fn x -> !fun.(x) end)

  @spec concat_if(any, (any -> boolean), [any]) :: [any]
  defp concat_if(item, fun, acc) do
    if fun.(item), do: acc ++ [item], else: acc
  end
end
