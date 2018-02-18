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

  match _ do
    send_resp(conn, 404, "Oops. Try /")
  end

end
