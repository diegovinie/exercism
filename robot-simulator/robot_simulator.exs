defmodule RobotSimulator do

  @direction_error {:error, "invalid direction"}
  @position_error {:error, "invalid position"}
  @order_error {:error, "invalid instruction"}

  @controls %{
    north: %{"A" => {0, 1}, "L" => :west, "R" => :east},
    east:  %{"A" => {1, 0}, "L" => :north, "R" => :south},
    south: %{"A" => {0, -1}, "L" => :east, "R" => :west},
    west:  %{"A" => {-1, 0}, "L" => :south, "R" => :north}
  }

  defstruct direction: :north, position: {0, 0}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    case valid_position?(position) do
      false -> @position_error
      true  -> case Map.has_key?(@controls, direction) do
        false -> @direction_error
        true  -> %RobotSimulator{direction: direction, position: position}
      end
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    case Regex.match? ~r/^[ALR]+$/, instructions do
      false -> @order_error
      true  ->
        String.graphemes(instructions) |> Enum.reduce(robot, &exec_order/2)
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end

  defp valid_position?({x, y}) when is_integer(x) and is_integer(y), do: true
  defp valid_position?(_), do: false

  defp exec_order("A", robot) do
    position = sum_duples(robot.position, @controls[robot.direction]["A"])
    %{robot | position: position}
  end
  defp exec_order(order, robot) do
    %{robot | direction: @controls[robot.direction][order]}
  end

  defp sum_duples(a, b) do
    {elem(a, 0) + elem(b, 0), elem(a, 1) + elem(b, 1)}
  end
end
