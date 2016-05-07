
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

  def escape_velocity(:moon) do
    Planets.moon
      |> escape_velocity
  end

  def escape_velocity(planet) when is_map(planet) do
    planet
    |> calculate_escape
    |> to_km
    |> to_nearest_tenth
  end

  def orbital_speed(:earth, height), do: orbital_speed(Planets.earth, height)
  def orbital_speed(:mars, height), do: orbital_speed(Planets.mars, height)
  def orbital_speed(:moon, height), do: orbital_speed(Planets.moon, height)
  def orbital_speed(planet, height) do
    newtons_gravitational_constant * planet.mass / orbital_radius(planet, height)
    |> :math.sqrt
  end


  def orbital_term(:earth, height), do: orbital_term(Planets.earth, height)
  def orbital_term(:mars, height), do: orbital_term(Planets.mars, height)
  def orbital_term(:moon, height), do: orbital_term(Planets.moon, height)
  def orbital_term(planet, height) do
    4 * (:math.pi |> squared)
    * (orbital_radius(planet, height) |> cubed)
    / (newtons_gravitational_constant * planet.mass)
    |> square_root
    |> seconds_to_hours
  end

  def orbital_accelartion(:earth, height), do: orbital_accelartion(Planets.earth, height)
  def orbital_accelartion(:mars, height), do: orbital_accelartion(Planets.mars, height)
  def orbital_accelartion(:moon, height), do: orbital_accelartion(Planets.moon, height)
  def orbital_accelartion(planet, height) do
   (orbital_speed(planet, height) |> squared) / orbital_radius(planet, height)
  end


  # def height(:earth, duration), do: height(Planets.earth, duration)
  # def height(planet, duration) do
  #   :math.pow(((newtons_gravitational_constant * planet.mass * (duration |> squared))
  #   /(4 * (:math.pi |> squared))) , 1/3) - planet.radius
  #   |> to_km
  # end

  def orbital_height(:earth, seconds), do: orbital_height(Planets.earth, seconds)
  def orbital_height(planet, seconds) do
    r = (newtons_gravitational_constant * planet.mass * (seconds |> squared)) /
    (4 * (:math.pi |> squared))
      |> cube_root
    r - planet.radius
      |> to_km
      |> to_nearest_tenth
  end


  defp orbital_radius(planet, height) do
    planet.radius + (height |> to_m)
  end

  defp calculate_escape(%{mass: mass, radius: radius}) do
    2 * newtons_gravitational_constant * mass / radius
      |> :math.sqrt
  end

end
