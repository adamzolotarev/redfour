defmodule RocketryTest do
  use ExUnit.Case

  doctest Physics.Rocketry

  import Physics.Rocketry

  test "Earth orbital accelaration is 9.51 at 100km" do
    a = Physics.Rocketry.orbital_acceleration(Planet.select[:earth], 100)
    assert a ==  9.515619587729839
  end

  test "Mars orbital accelaration is 3.48 at 100km" do
    a = Physics.Rocketry.orbital_acceleration(Planet.select[:mars], 100)
    assert a == 3.5507893928194743
  end

  test "Earth orbital speed is 7845 m/s at 100km" do
    a = Physics.Rocketry.orbital_speed(Planet.select[:earth], 100)
    assert a == 7846.404191259335
  end

  test "Mars orbital speed is 7845 m/s at 100km" do
    a = Physics.Rocketry.orbital_speed(Planet.select[:mars], 100)
    assert a == 3510.1622744658935
  end

  test "Orbital term at 100km for Earth should be 1.5 hours" do
    a = Physics.Rocketry.orbital_term(Planet.select[:earth], 100)
    assert a ==  1.5
  end

  test "Not sure if this is right; Orbital height for 1.5 hours" do
    a = Physics.Rocketry.orbital_height(Planet.select[:earth], 1.5*60*60)
    assert a ==  281.1
  end



  test "Orbital acceleration defaults to Earth" do
    x = Physics.Rocketry.orbital_acceleration(100)
    assert x == 9.515619587729839
  end

  test "Orbital term at 100km defaults to Earth" do
    x = Physics.Rocketry.orbital_term(100)
    assert x == 1.5
  end

  test "Orbital acceleration for Jupiter at 100km" do
    x = Physics.Rocketry.orbital_acceleration(Planet.select[:jupiter], 100)
    assert x == 24.659005330334
  end

  # @tag :pending
  test "Orbital term at 100km for Saturn at 6000km" do
    x = Physics.Rocketry.orbital_term(Planet.select[:saturn], 6000)
    assert x == 4.9
  end

end
