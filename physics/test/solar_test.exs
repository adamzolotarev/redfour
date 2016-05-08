defmodule SolarTest do
  use ExUnit.Case
  use Timex
  # use Physics.Rocketry
  doctest Solar

  setup do
    flares =[
      %{classification: :X, scale: 99, date: Date.from({1859,8,29})},
      %{classification: :M, scale: 5.8, date: Date.from({2015, 1, 12})},
      %{classification: :M, scale: 1.2, date: Date.from({2015, 2, 9})},
      %{classification: :C, scale: 3.2, date: Date.from({2015, 4, 18})},
      %{classification: :M, scale: 83.6, date: Date.from({2015, 6, 23})},
      %{classification: :C, scale: 2.5, date: Date.from({2015, 7, 4})},
      %{classification: :X, scale: 72, date: Date.from({2012, 7, 23})},
      %{classification: :X, scale: 45, date: Date.from({2003, 11, 4})},
    ]
    {:ok, data: flares}
  end

  test "We have 8 solar flares", %{data: flares} do
    assert length(flares) == 8
  end

  test "power of X classification with 99 scale is 99000" do
    p = Solar.power(%{classification: :X, scale: 99})
    assert p == 99000
  end

  test "power of M classification with 99 scale is 990" do
    p = Solar.power(%{classification: :M, scale: 99})
    assert p == 990
  end

  test "power of c classification with 99 scale is 99" do
    p = Solar.power(%{classification: :C, scale: 99})
    assert p == 99
  end

  test "No EVA when power is greater than 1000" do
    p = Solar.no_eva([%{classification: :X, scale: 2}])
    assert length(p) == 1
  end

  test "Do EVA when power is 1000" do
    p = Solar.no_eva([%{classification: :X, scale: 1}])
    assert length(p) == 0
  end

  test "Do EVA when power is less than 1000" do
    p = Solar.no_eva([%{classification: :M, scale: 99}])
    assert length(p) == 0
  end

  test "Go inside", %{data: flares} do
    d = Solar.no_eva(flares)
    assert length(d) == 3
  end
end
