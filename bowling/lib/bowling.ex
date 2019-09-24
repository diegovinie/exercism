defmodule Bowling do

  defstruct [score: 0, throws: 0, last: 0, status: nil, first: true]

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start do
    %Bowling{}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """

  @spec roll(any, integer) :: any | String.t()
  def roll(%Bowling{score: score, throws: throws} = game, roll) do
    if (!game.first and spare?(game.last, roll)) do
      %Bowling{
        score: score,
        throws: throws + 1,
        last: 10,
        first: true,
        status: :spare
      }
    end

    %Bowling{
      score: score + roll,
      throws: throws + 1,
      last: roll,
      first: !game.first
    }
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """

  @spec score(any) :: integer | String.t()
  def score(%Bowling{score: score}) do
    score
  end

  def spare?(previous, current) do
    previous + current == 10
  end
end
