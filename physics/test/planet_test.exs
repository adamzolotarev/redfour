defmodule PlanetTest do
  use ExUnit.Case
  use Timex

  doctest Planet

  test "We have 8 planets" do
    assert length(Planet.load) == 8
  end

  test "Selecting Earth should return Earth" do
    earth = Planet.select[:earth]
    assert earth == %Planet{name: "Earth", type: :rocky, mass: 5.972e24, radius: 6.37e6}
  end

  test "The earth has escape velocity of 11.2 km/s" do
    earth = Planet.load[:earth]
    assert earth.escape_velocity == 11.2
  end

end
