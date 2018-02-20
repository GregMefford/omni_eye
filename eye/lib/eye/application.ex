defmodule Eye.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    picam_camera = Application.get_env(:picam, :camera)

    children = [
      child_spec_no_args(picam_camera),
      Eye.Camera,
      Eye.BarcodeScanner
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: Eye.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp child_spec_no_args(module) do
    %{id: module, start: {module, :start_link, []}}
  end

end
