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
    armies[id] |> get_strongest |> IO.inspect
    armies
  end

  @spec strongest_died(armies, integer) :: armies
  def strongest_died(armies, id) do
    army = armies[id]
    strongest = get_strongest(army)

    %{armies | id => Enum.filter(armies[id], fn soldier ->
      soldier != strongest
      end)
    }
  end

  @spec recruit(armies, integer, integer) :: armies
  def recruit(armies, id, soldier) do
    %{armies | id => [ soldier | armies[id] ]}
  end

  @spec merge(armies, integer, integer) :: armies
  def merge(armies, a, b) do
    %{armies | a => Enum.concat(armies[a], armies[b])}
    |> Map.delete(b)
  end

  ################## AUX #########################

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
  defp get_strongest(army), do: Enum.max(army)

  #################### IO #########################

  def read() do
    [armies, _] = IO.read(:line) |> String.trim |> String.split

    orders = IO.read(:all)
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split
      |> Enum.map(&String.to_integer/1)
    end)

    {armies |> String.to_integer |> create_armies, orders}
  end
end

Solution.run()
