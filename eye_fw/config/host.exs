use Mix.Config

# Pull in the `dev` configuration from the `eye_ui` application
# when running on the `host` target.
import_config "../../eye_ui/config/dev.exs"

# Disable `:code_reloader` when running from `eye_fw` because
# it is declared as `only: :dev` in the `eye_ui` application,
# so it won't be available when `eye_ui` is added as a dependency.
config :eye_ui, EyeUiWeb.Endpoint,
  code_reloader: false

config :logger,
  level: :debug

config :logger, :console,
  level: :debug,
  format: "[$level] $message\n"

