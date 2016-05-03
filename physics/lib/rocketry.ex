
defmodule Physics.Rocketry do

  import Calcs
  import Physics.Laws

  def escape_velocity(:earth) do
    Planets.earth
      |> escape_velocity
  end

  def escape_velocity(:mars) do
    Planets.mars
      |> escape_velocity
  end

  def escape_velocity(planet) when is_map(planet) do
    planet
    |> calculate_escape
    |> to_km
    |> to_neareset_tenth
  end

  def orbital_speed(height) do
    newtons_gravitational_constant * Planets.earth.mass / orbital_radius(height)
  end

  defp orbital_radius(height) do
    Planets.earth.radius + (height |> to_m)
  end

  defp calculate_escape(%{mass: mass, radius: radius}) do
    2 * newtons_gravitational_constant * mass / radius
      |> :math.sqrt
  end
end
