defmodule EyeUi.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      EyeUiWeb.Endpoint,
      {Task.Supervisor, [name: EyeUi.TaskSupervisor]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: EyeUi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    EyeUiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
