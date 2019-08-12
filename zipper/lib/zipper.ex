defmodule Zipper do

  import BinTree

  @type trail :: {:left, any, BinTree.t, trail}
                |{:right, any, BinTree.t, trail}
                | :top

  @type t :: {BinTree.t, trail}

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
    {bin_tree, :top}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree({ bin_tree, :top }), do: bin_tree
  def to_tree({ bin_tree, {:left, data, right, trail} }) do
    to_tree({ %BinTree{ value: data, left: bin_tree, right: right }, trail })
  end
  def to_tree({ bin_tree, {:right, data, left, trail} }) do
    to_tree({ %BinTree{ value: data, right: bin_tree, left: left }, trail })
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value({nil, _}), do: nil
  def value({ %BinTree{value: value}, _ }), do: value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left({ %BinTree{left: nil}, _ }), do: nil
  def left({ %BinTree{value: value, left: left, right: right}, trail }) do
    {left, {:left, value, right, trail}}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right({ %BinTree{right: nil}, _ }), do: nil
  def right({ %BinTree{value: value, left: left, right: right}, trail }) do
    {right, {:right, value, left, trail}}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up({_, :top}), do: nil
  def up({ bin_tree, {direction, value, other, trail} }) do
    case direction do
      :left  -> {%BinTree{value: value, left: bin_tree, right: other}, trail}
      :right -> {%BinTree{value: value, left: other, right: bin_tree}, trail}
    end
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value({bin_tree, trail}, value) do
    {%{bin_tree | value: value} , trail}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left({bin_tree, trail}, left) do
    {%{bin_tree | left: left}, trail}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right({bin_tree, trail}, right) do
    {%{bin_tree | right: right}, trail}
  end
end
