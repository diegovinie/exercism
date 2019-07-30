defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list, non_neg_integer) :: non_neg_integer
  def count(list, counter \\ 0)
  def count([], counter), do: counter
  def count([_ | tail], counter), do: count(tail, counter + 1)

  @spec reverse(list) :: list
  def reverse(l), do: reduce(l, [], fn(item, acc) -> [item | acc] end)

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: for item <- l, do: f.(item)

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: for item <- l, f.(item), do: item

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([head | tail], acc, f), do: reduce(tail, f.(head, acc), f)

  @spec append(list, list) :: list
  def append([], b), do: b
  def append([head | tail], b), do: [head | append(tail, b)]

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([head | tail]), do: append(head, concat(tail))
end
