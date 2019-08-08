defmodule Solution do

  def main() do
    [fst | _] = points = read()
    calc_polygon_area(points, fst)
    |> IO.puts
  end

  def calc_polygon_area([last | []], close_point), do: calc_trap(last, close_point)
  def calc_polygon_area([fst | [snd | _] = points], close_point) do
    calc_trap(fst, snd) + calc_polygon_area(points, close_point)
  end

  def calc_trap({x1, y1}, {x2, y2}) do
    with  offset  <- min(y2, y1),
          base    <- -(x2 - x1),
          h       <- abs(y2 - y1),
    do: (base * offset) + ((base * h)/2)
  end

################ IO ####################

  def read() do
    points = IO.read(:line) |> String.trim_trailing |> String.to_integer

    for _ <- 1..points, do: read_line()
  end

  def read_line() do
    IO.read(:line) |> parse_line
  end

  defp parse_line(line) do
    line
    |> String.trim_trailing
    |> String.split
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple
  end
end

Solution.main()
