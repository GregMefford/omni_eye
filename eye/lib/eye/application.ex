defmodule Eye.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      child_spec_no_args(Picam.Camera),
      Plug.Adapters.Cowboy.child_spec(:http, Eye.Router, [], [port: 80])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Eye.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp child_spec_no_args(module) do
    %{id: module, start: {module, :start_link, []}}
  end

end
