defmodule EyeUi.Publishers.Barcode do

  require Logger

  def child_spec(opts \\ []) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, opts}
    }
  end

  def start_link do
    Task.Supervisor.start_child(EyeUi.TaskSupervisor, & stream/0, restart: :permanent)
  end

  defp stream do
    symbols = EyeUi.Resolvers.Barcode.get_next_scan()
    Logger.debug(fn -> "Publishing barcode scans: #{inspect symbols}" end)
    EyeUi.Publisher.publish(symbols, barcodes: "*")
    stream()
  end
end
