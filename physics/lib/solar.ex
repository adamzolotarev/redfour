defmodule Solar do

  def power(%{classification: :X, scale: s}), do: 1000 *s
  def power(%{classification: :M, scale: s}), do: 10 *s
  def power(%{classification: :C, scale: s}), do: s

end
