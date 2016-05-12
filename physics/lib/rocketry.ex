
defmodule Physics.Rocketry do

  import Calcs
  import Physics.Laws

  @earth Planet.select[:earth]

  def orbital_acceleration(height), do: orbital_acceleration(@earth, height)
  def orbital_acceleration(planet, height) do
    (orbital_speed(planet, height) |> squared) / orbital_radius(planet, height)
  end

  def orbital_term(height), do: orbital_term(@earth, height)
  def orbital_term(planet, height) do
    4 * (:math.pi |> squared) * (orbital_radius(planet,height) |> cubed) / (newtons_gravitational_constant * planet.mass)
      |> square_root
      |> seconds_to_hours
  end

  def orbital_speed(height), do: orbital_speed(@earth,height)
  def orbital_speed(planet, height) do
    newtons_gravitational_constant * planet.mass / orbital_radius(planet, height)
      |> square_root
  end

  defp orbital_radius(planet, height) do
    planet.radius + (height |> to_m)
  end

  def orbital_height(:earth, seconds), do: orbital_height(Planet.earth, seconds)
  def orbital_height(planet, seconds) do
    r = (newtons_gravitational_constant * planet.mass * (seconds |> squared)) /
    (4 * (:math.pi |> squared))
      |> cube_root
    r - planet.radius
      |> to_km
      |> to_nearest_tenth
  end

end
