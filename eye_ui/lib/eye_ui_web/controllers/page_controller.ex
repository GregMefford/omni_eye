defmodule EyeUiWeb.PageController do
  use EyeUiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
