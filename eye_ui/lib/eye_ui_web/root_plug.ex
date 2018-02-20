defmodule EyeUiWeb.RootPlug do
  import Plug.Conn

  def init(opts), do: opts
  def call(conn, _opts) do
    conn
      |> Phoenix.Controller.redirect(to: "/index.html")
      |> halt
  end
end
