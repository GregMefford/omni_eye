defmodule Eye.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    markup = """
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="UTF-8" />
      <title>Eye - Video Stream</title>
    </head>
    <body> <img src="video.mjpg" /> </body>
    </html>
    """
    conn
    |> put_resp_header("Content-Type", "text/html")
    |> send_resp(200, markup)
  end

  forward "/video.mjpg", to: Eye.JPEGStreamer

  get "/barcodes.json" do
    response =
      Eye.BarcodeScanner.next_scan()
      |> format_symbols()
      |> Jason.encode!()

    conn
    |> put_resp_header("Age", "0")
    |> put_resp_header("Cache-Control", "no-cache, private")
    |> put_resp_header("Pragma", "no-cache")
    |> put_resp_header("Content-Type", "text/json")
    |> send_resp(200, response)
  end

  match _ do
    send_resp(conn, 404, "Oops. Try /")
  end

  defp format_symbols(nil), do: []
  defp format_symbols(symbols), do: Enum.map(symbols, & format_symbol/1)

  defp format_symbol(%Zbar.Symbol{} = symbol) do
    symbol
    |> Map.from_struct()
    |> Map.update!(:points, & format_points/1)
  end

  defp format_points(points), do: Enum.map(points, & format_point/1)

  defp format_point({x, y}), do: %{x: x, y: y}
end
