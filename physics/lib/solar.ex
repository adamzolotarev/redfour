defmodule Solar do

  def power(%{classification: :X, scale: s}), do: 1000 *s
  def power(%{classification: :M, scale: s}), do: 10 *s
  def power(%{classification: :C, scale: s}), do: s

  def no_eva(flares) do
    Enum.filter flares, &(power(&1) > 1000)
    # Enum.filter flares, fn(flare) ->
    #   power(flare) > 1000
  end

  def deadliest(flares) do
    Enum.map(flares, &(power(&1)))
      |> Enum.max
  end

  def total_flare_power(flares) do
    Enum.map(flares, &(power(&1)))
      |> Enum.sum
  end

  def total_flare_power_recursive(flares), do:  total_flare_power_recursive(flares, 0)
  def total_flare_power_recursive([], totalPower), do: totalPower
  def total_flare_power_recursive([head|tail], totalPower) do
     total_flare_power_recursive(tail, totalPower + power(head))
  end

  def total_flare_power_with_reduce(flares) do
  Enum.reduce flares, 0, fn(flare, total) ->
      power(flare) + total
    end
  end

  def total_flare_power_with_comprehension(flares) do
      (for flare <- flares, do: power(flare))
      |> Enum.sum
  end

  def flare_list(flares) do
    Enum.map flares, fn(flare) ->
      p = power(flare)
      %{power: p, is_deadly: p > 1000}
    end
  end

end
