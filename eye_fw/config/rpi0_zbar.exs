use Mix.Config

# Pull in the `prod` configuration from the `eye_ui` application
# when running on the `rpi0_zbar` target.
import_config "../../eye_ui/config/prod.exs"

config :eye_ui, EyeUiWeb.Endpoint,
  http: [port: 80],
  url: [host: "0.0.0.0", port: 80],
  # Start the server since we're running in a release instead of through `mix`
  server: true,
  # We can't easily check the origin because the host you connect to will
  # end up being whatever the device's IP address is
  check_origin: false,
  # We don't load from system env because we bake it into the Nerves firmware either way
  load_from_system_env: false

config :logger,
  compile_time_purge_level: :info,
  level: :info,
  utc_log: true

config :logger, :console,
  level: :info,
  format: "$dateT$time [level=$level $metadata] $message\n",
  metadata: [:module]

