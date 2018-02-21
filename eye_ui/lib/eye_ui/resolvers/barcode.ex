defmodule EyeUi.Resolvers.Barcode do

  def get_next_scan(_parent, _args, _resolution) do
    {:ok, get_next_scan()}
  end

  def get_next_scan do
    Eye.BarcodeScanner.next_scan()
    |> format_symbols()
  end

  defp format_symbols(nil), do: []
  defp format_symbols(symbols), do: Enum.map(symbols, & format_symbol/1)

  defp format_symbol(symbol), do: Map.update!(symbol, :points, & format_points/1)

  defp format_points(points), do: Enum.map(points, & format_point/1)

  defp format_point({x, y}), do: %{x: x, y: y}

end
