defmodule SolarTest do
  use ExUnit.Case
  use Timex
  import Solar.Flare
  # use Physics.Rocketry
  doctest Solar.Flare

  setup do
    flares =[
      %Solar.Flare{classification: :X, scale: 99, date: Date.from({1859,8,29})},
      %Solar.Flare{classification: :M, scale: 5.8, date: Date.from({2015, 1, 12})},
      %Solar.Flare{classification: :M, scale: 1.2, date: Date.from({2015, 2, 9})},
      %Solar.Flare{classification: :C, scale: 3.2, date: Date.from({2015, 4, 18})},
      %Solar.Flare{classification: :M, scale: 83.6, date: Date.from({2015, 6, 23})},
      %Solar.Flare{classification: :C, scale: 2.5, date: Date.from({2015, 7, 4})},
      %Solar.Flare{classification: :X, scale: 72, date: Date.from({2012, 7, 23})},
      %Solar.Flare{classification: :X, scale: 45, date: Date.from({2003, 11, 4})},
    ]
    {:ok, data: flares}
  end

  test "We have 8 solar flares", %{data: flares} do
    assert length(flares) == 8
  end

  test "power of X classification with 99 scale is 99000" do
    p = power(%{classification: :X, scale: 99})
    assert p == 99000
  end

  test "power of M classification with 99 scale is 990" do
    p = power(%{classification: :M, scale: 99})
    assert p == 990
  end

  test "power of c classification with 99 scale is 99" do
    p = power(%{classification: :C, scale: 99})
    assert p == 99
  end

  test "No EVA when power is greater than 1000" do
    p = no_eva([%{classification: :X, scale: 2}])
    assert length(p) == 1
  end

  test "Do EVA when power is 1000" do
    p = no_eva([%{classification: :X, scale: 1}])
    assert length(p) == 0
  end

  test "Do EVA when power is less than 1000" do
    p = no_eva([%{classification: :M, scale: 99}])
    assert length(p) == 0
  end

  test "Go inside", %{data: flares} do
    d = no_eva(flares)
    assert length(d) == 3
  end

  test "Deadliest flare is 99000", %{data: flares} do
    d = deadliest(flares)
    assert d == 99000
  end

  test "A list of flares", %{data: flares} do
    result = flare_list(flares)
    assert result == [
    %{power: 99000, is_deadly: true},
    %{power: 58.0, is_deadly: false},
    %{power: 12.0, is_deadly: false},
    %{power: 3.2, is_deadly: false},
    %{power: 836.0, is_deadly: false},
    %{power: 2.5, is_deadly: false},
    %{power: 72000, is_deadly: true},
    %{power: 45000, is_deadly: true}
  ]
  end

  test "A Solar Flare is a Map with a special key" do
    assert %Solar.Flare{}.__struct__ == Solar.Flare
  end

end
