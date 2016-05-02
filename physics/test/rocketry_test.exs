defmodule RocketryTest do
  use ExUnit.Case
  # use Physics.Rocketry
  doctest Physics.Rocketry

  test "planet with earth characteristics has escape velocity of 11.2" do
    v = %{mass: 5.972e24, radius: 6.371e6}
      |> Physics.Rocketry.escape_velocity
    assert v == 11.2
  end

  test "the earth has escape velocity of 11.2 km/s" do
    v =:earth
      |> Physics.Rocketry.escape_velocity
    assert v == 11.2
  end

  test "the Mars has escape velocity of 5.1 km/s" do
    v =:mars
      |> Physics.Rocketry.escape_velocity
    assert v == 5.1
  end

  test "the Moon has escape velocity of .0238 km/s" do
    v =:mars
      |> Physics.Rocketry.escape_velocity
    assert v == 5.1
  end

end
