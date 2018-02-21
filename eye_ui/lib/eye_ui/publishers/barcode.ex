defmodule EyeUi.Publishers.Barcode do

  require Logger

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
