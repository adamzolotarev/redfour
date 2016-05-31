defmodule OTPTest do
  use ExUnit.Case

  test "A simple spawn" do
    res = spawn fn() -> IO.inspect "HI" end
    IO.inspect res
  end

  test "A simple spawn 2 times" do
  res = for n <- 1..2, do: spawn(fn() -> IO.inspect "HI" end)
end

end
