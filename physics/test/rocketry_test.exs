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

  test "the Moon has escape velocity of 2.4 km/s" do
    v =:moon
      |> Physics.Rocketry.escape_velocity
    assert v == 2.4
  end

  test "Earth orbital accelaration is 9.51 at 100km" do
    a = Physics.Rocketry.orbital_accelartion(:earth, 100)
    assert a == 9.512678810620692
  end

  test "Mars orbital accelaration is 3.48 at 100km" do
    a = Physics.Rocketry.orbital_accelartion(:mars, 100)
    assert a == 3.4792897959183673
  end

  test "Moon orbital accelaration is 1.45 at 100km" do
    a = Physics.Rocketry.orbital_accelartion(:moon, 100)
    assert a ==  1.4511829222519155
  end

  test "Earth orbital speed is 7845 m/s at 100km" do
    a = Physics.Rocketry.orbital_speed(:earth, 100)
    assert a ==  7845.797893364734
  end

  test "Mars orbital speed is 7845 m/s at 100km" do
    a = Physics.Rocketry.orbital_speed(:mars, 100)
    assert a ==  3489.6295341646633
  end

  test "Moon orbital speed is 7845 m/s at 100km" do
    a = Physics.Rocketry.orbital_speed(:moon, 100)
    assert a ==  1633.179172993282
  end


  test "Orbital term at 100km for Earth should be 1.5 hours" do
    a = Physics.Rocketry.orbital_term(:earth, 100)
    assert a ==  1.5
  end

  test "Not sure if this is right; Orbital height for 1.5 hours" do
    a = Physics.Rocketry.orbital_height(:earth, 1.5*60*60)
    assert a ==  280.1
  end


end
