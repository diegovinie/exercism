defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @enforce_keys [:data]
  defstruct [:left, :right, :data]

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %BinarySearchTree{data: data}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(%{data: current} = tree, data) when data > current do
    %{tree | right: move_right(tree, data)}
  end

  def insert(tree, data), do: %{tree | left: move_left(tree, data)}

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(nil), do: []
  def in_order(%{data: data, left: left, right: right}) do
    in_order(left) ++ [data] ++ in_order(right)
  end

  defp move_left(%{left: slot}, data) when is_nil(slot), do: new(data)
  defp move_left(%{left: slot}, data), do: insert(slot, data)

  defp move_right(%{right: slot}, data) when is_nil(slot), do: new(data)
  defp move_right(%{right: slot}, data), do: insert(slot, data)
end
