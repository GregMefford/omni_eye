defmodule EyeUiWeb.SnapPlug do
  import Plug.Conn

  def init(opts), do: opts
  def call(conn, _opts) do
    conn
    |> put_resp_header("Age", "0")
    |> put_resp_header("Cache-Control", "no-cache, private")
    |> put_resp_header("Pragma", "no-cache")
    |> put_resp_header("Content-Type", "image/jpeg")
    |> send_resp(200, Eye.Camera.next_frame())
  end

end
