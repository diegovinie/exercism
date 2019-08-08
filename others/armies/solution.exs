defmodule Solution do
  @type armies :: Map.t()

  @events %{
    1 => :find_strongest,
    2 => :strongest_died,
    3 => :recruit,
    4 => :merge
  }

  def run() do
    read() |> execute
  end

  ################## events ##################

  @spec find_strongest(armies, integer) :: armies
  def find_strongest(armies, id) do
    armies[id] |> get_strongest |> IO.puts
    armies
  end

  @spec strongest_died(armies, integer) :: armies
  def strongest_died(armies, id) do
    [_strongest | rest] = armies[id]
    %{armies | id => rest}
  end

  @spec recruit(armies, integer, integer) :: armies
  def recruit(armies, id, soldier) do
    %{ armies | id => add_soldier(armies[id], soldier) }
  end

  @spec merge(armies, integer, integer) :: armies
  def merge(armies, a, b) do
    %{armies | a => compare_merge(armies[a], armies[b])}
    |> Map.delete(b)
  end

  ################## AUX #########################

  def add_soldier([strongest | rest], soldier) when strongest > soldier do
    [strongest | add_soldier(rest, soldier)]
  end
  def add_soldier([], soldier), do: [soldier]
  def add_soldier(army, soldier), do: [soldier | army]

  @spec create_armies(non_neg_integer, armies) :: armies
  defp create_armies(length, armies \\ %{})
  defp create_armies(0, armies), do: armies
  defp create_armies(length, armies) do
    create_armies(length - 1, Map.put(armies, length, []))
  end

  @spec execute({armies, [integer]}) :: armies
  defp execute({armies, []}), do: armies
  defp execute({armies, [event | rest]}) do
    execute {exec_order(armies, event), rest}
  end

  @spec exec_order(armies, [integer]) :: armies
  defp exec_order(armies, [order | payload]) do
    apply __MODULE__, @events[order], [armies | payload]
  end

  @spec get_strongest([integer]) :: integer
  defp get_strongest([strongest | _]), do: strongest

  @spec compare_merge([integer], [integer]) :: [integer]
  def compare_merge(as, []), do: as
  def compare_merge([], bs), do: bs
  def compare_merge([a | rest_a] = as, [b | rest_b] = bs) do
    case a > b do
      true -> [a | compare_merge(rest_a, bs)]
      false -> [b | compare_merge(as, rest_b)]
    end
  end

  #################### IO #########################
  @space 32
  def parse(line, v \\ 0, acc \\ [])
  def parse(<<>>, v, acc), do: Enum.reverse([v|acc])
  def parse("\n", v, acc), do: parse("", v, acc)
  def parse(<<@space, rest::binary>>, v, acc), do: parse(rest, 0, [v|acc])
  def parse(<<c, rest::binary>>, v, acc), do: parse(rest, v * 10 + (c - ?0), acc)

  def read() do
    [armies, _] = IO.read(:line) |> String.trim |> String.split

    orders = IO.binstream(:stdio, :line)
    |> Enum.map(fn line -> parse(line) end)

    {armies |> String.to_integer |> create_armies, orders}
  end
end

Solution.run()
