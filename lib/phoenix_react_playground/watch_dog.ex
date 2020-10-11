defmodule PoC.WatchDog do
  use GenServer

  @buffer_count 2

  @impl true
  def start_link(_initial_value) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def increment(id, timestamp \\ DateTime.utc_now() |> DateTime.to_unix(:millisecond)),
    do: GenServer.call(__MODULE__, {:increment, id, timestamp})

  def get_average_value(id),
    do: GenServer.call(__MODULE__, {:get, id})

  @impl true
  def handle_call({:increment, id, timestamp}, _from, state) do
    prev =
      state
      |> Map.get(id, [now()])
      |> Enum.slice(0, @buffer_count)

    {:reply, :ok, Map.put(state, id, [timestamp | prev])}
  end

  @impl true
  def handle_call({:get, id}, _from, state) do
    timestamps = Map.get(state, id, [now()])

    average =
      timestamps
      |> Enum.zip(tl(timestamps))
      |> Enum.reduce(0, fn {t_1, t_2}, acc -> t_1 - t_2 + acc end)
      |> div(@buffer_count)

    {:reply, average, state}
  end

  defp now, do: DateTime.utc_now() |> DateTime.to_unix()
end
