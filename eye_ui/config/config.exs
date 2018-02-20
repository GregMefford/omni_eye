# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Splitting the base config out into a separate file allows us to import
# each of the configs separately in the `eye_fw` app, without pulling in
# the environment-specific ones.
import_config "base.exs"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
