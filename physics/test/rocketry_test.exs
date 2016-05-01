defmodule RocketryTest do
  use ExUnit.Case
  # use Physics.Rocketry
  doctest Physics.Rocketry

  test "the earth has escape velocity of 11.2" do
    v =:earth
      |> Physics.Rocketry.escape_velocity
    assert v == 11.2
  end

  test "planet with earth characteristics has escape velocity of 11.2" do
    v = %{mass: 5.972e24, radius: 6.371e6}
      |> Physics.Rocketry.escape_velocity
    assert v == 11.2
  end
end
