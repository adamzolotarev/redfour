ExUnit.start()

defmodule Helpers do
  def check_flare_count do
    {:ok, pid} = Postgrex.Connection.start_link(
        hostname: "localhost",
        database: "redfour",
        username: "test",
        password: "test")

    res = Postgrex.Connection.query!(pid, "select count(1) from solar_flares;", [])
    Postgrex.Connection.stop(pid)
    [[count] | rest] = res.rows
    count
  end
end

defmodule SolarFlareWorker do
  def run(spawns) when is_integer(spawns) do
    {:ok, pid} = SolarFlareRecorder.start_link
    Enum.map 1..spawns, fn(n) ->
      SolarFlareRecorder.record(pid, %{index: n, classification: "X", scale: 33})
    end
  end
end
