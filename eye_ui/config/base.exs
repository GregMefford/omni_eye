use Mix.Config

# Configures the endpoint
config :eye_ui, EyeUiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dwofDhSPP7tOKgHRwAo26xUzSIfdnTD+90W4wyeyAZdZOfZFiKZVox7DXhD+XUAV",
  render_errors: [view: EyeUiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: EyeUi.PubSub, adapter: Phoenix.PubSub.PG2]
