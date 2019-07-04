defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @rel_earth %{
    mercury:  0.2408467,
    venus:    0.61519726,
    earth:    1,
    mars:     1.8808158,
    jupiter:  11.862615,
    saturn:   29.447498,
    uranus:   84.016846,
    neptune:  164.79132
  }

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, float) :: float
  def age_on(planet, seconds) do
    to_planet_age(planet).(to_earth_years seconds)
  end

  @spec to_earth_years(integer) :: float
  defp to_earth_years(seconds), do: seconds / 31_557_600

  @spec to_planet_age(planet) :: fun
  defp to_planet_age(planet), do: &(&1 / @rel_earth[planet])
end
