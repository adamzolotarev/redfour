defmodule SolarFlareRecorder do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__,[])
  end

  def record(pid, flare) do
    GenServer.cast(pid, {:new, flare})
  end

  def current(pid) do
    GenServer.call(pid, :load)
  end

  def handle_call(:load, _sender, state) do
    {:reply, get_flares, []}
  end

  def handle_cast({:new, flare}, state) do
    add_flare(flare)
    {:noreply, []}
  end

  defp add_flare(flare) do
    """
    insert into solar_flares(classification, scale, date, index)
    values($1, $2, now(), $3) RETURNING *;
    """
    |> execute([flare.classification, flare.scale, flare.index])
  end

  defp get_flares do
    """
    select * from solar_flares;
    """
    |> execute
  end

  defp execute(sql,params \\ []) do
    {:ok, pid} = connect

    res = Postgrex.Connection.query!(pid, sql, params) |> transform_result
    Postgrex.Connection.stop(pid)
    res
  end

  defp connect do
    Postgrex.Connection.start_link(
        hostname: "localhost",
        database: "redfour",
        username: "test",
        password: "test")
  end

  defp transform_result(result) do
    atomized = for col <- result.columns, do: String.to_atom(col)
    for row <- result.rows, do: List.zip([atomized, row]) |> Enum.into(%{})
  end

end
