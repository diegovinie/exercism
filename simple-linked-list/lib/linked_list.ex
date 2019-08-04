defmodule LinkedList do
  @opaque t :: tuple()

  @empty_list {nil, nil}

  @error_empty {:error, :empty_list}

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: @empty_list

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem), do: {elem, list}

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t, non_neg_integer) :: non_neg_integer()
  def length(list, acc \\ 0)
  def length(@empty_list, acc), do: acc
  def length({_, next}, acc), do: length(next, acc + 1)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(@empty_list), do: true
  def empty?(_), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({data, _} = list) do
    case empty?(list) do
      true  -> @error_empty
      false -> {:ok, data}
    end
  end

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({nil, _}), do: @error_empty
  def tail({_, next}), do: {:ok, next}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(@empty_list), do: @error_empty
  def pop({data, next}), do: {:ok, data, next}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    list
    |> Enum.reverse
    |> Enum.reduce(@empty_list, &push(&2, &1))
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(@empty_list), do: []
  def to_list({data, next}), do: [data | to_list(next)]

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    list |> to_list |> Enum.reverse |> from_list
  end
end
