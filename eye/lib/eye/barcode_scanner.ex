defmodule Eye.BarcodeScanner do
  use GenServer
  alias Eye.Camera

  require Logger

  # BarcodeScanner API

  def next_scan(timeout \\ 10_000) do
    GenServer.call(__MODULE__, :next_scan, timeout)
  end

  # GenServer API

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    send(self(), :scan_next_frame)
    {:ok, state}
  end

  def handle_call(:next_scan, from, state) do
    {:noreply, [from | state]}
  end

  def handle_info(:scan_next_frame, state) do
    {:ok, symbols} =
      Camera.next_frame()
      |> Zbar.scan()

    dispatch(symbols, state)

    send(self(), :scan_next_frame)
    {:noreply, []}
  end

  # Helpers

  defp dispatch(symbols, requests) do
    Enum.each(requests, & GenServer.reply(&1, symbols))
  end

end
