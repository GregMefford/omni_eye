defmodule Eye.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    cowboy_opts = [
      port: Application.get_env(:eye, :port, 80),
      protocol_options: [idle_timeout: :infinity]
    ]

    # List all child processes to be supervised
    children = [
      Application.get_env(:picam, :camera, Picam.Camera),
      Eye.Camera,
      Eye.BarcodeScanner,
      Plug.Cowboy.child_spec(scheme: :http, plug: Eye.Router, options: cowboy_opts)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: Eye.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
