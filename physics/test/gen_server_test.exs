defmodule GenServerTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = Postgrex.Connection.start_link(
        hostname: "localhost",
        database: "redfour",
        username: "test",
        password: "test")

    Postgrex.Connection.query!(pid, "delete from solar_flares;", [])
    Postgrex.Connection.stop(pid)
  end
  #
  # test "A Simple service" do
  #   {:ok, pid} = SolarFlareRecorder.start_link()
  #   SolarFlareRecorder.record(pid, %{classification: "M", scale: 22, index: 1})
  #   SolarFlareRecorder.record(pid, %{classification: "X", scale: 33, index: 2})
  #   res = SolarFlareRecorder.current(pid)
  #   IO.inspect res
  # end


  # test "Inserting 100 flares asynchronously" do
  #   res = Enum.map 1..100, fn(n) ->
  #     {:ok, pid} = SolarFlareRecorder.start_link
  #     SolarFlareRecorder.record(pid, %{index: n, classification: "X", scale: 33})
  #   end
  #   :timer.sleep(1000)
  #   assert Helpers.check_flare_count == 100
  # end

  test "Using worker to run 10 recorders concurrently" do
    res = Enum.map 1..10, fn(n) ->
      spawn(SolarFlareWorker, :run, [100])
    end
    :timer.sleep(1000)
  end


end
