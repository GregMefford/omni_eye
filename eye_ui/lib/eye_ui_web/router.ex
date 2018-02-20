defmodule EyeUiWeb.Router do
  use EyeUiWeb, :router

  forward "/video.mjpg", EyeUi.JPEGStreamer

  forward "/graphql", Absinthe.Plug,
    schema: EyeUi.Schema

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: EyeUi.Schema,
    socket: EyeUiWeb.UserSocket,
    interface: :simple

  forward "/", EyeUiWeb.RootPlug

end
