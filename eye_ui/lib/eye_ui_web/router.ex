defmodule EyeUiWeb.Router do
  use EyeUiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  forward "/video.mjpg", EyeUi.JPEGStreamer

  forward "/graphql", Absinthe.Plug,
    schema: EyeUi.Schema

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: EyeUi.Schema,
    socket: EyeUiWeb.UserSocket,
    interface: :simple

  scope "/", EyeUiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", EyeUiWeb do
  #   pipe_through :api
  # end
end
