defmodule EyeFw.MixProject do
  use Mix.Project

  @target System.get_env("MIX_TARGET") || "host"

  def project do
    [
      app: :eye_fw,
      version: "0.1.0",
      elixir: "~> 1.4",
      target: @target,
      archives: [nerves_bootstrap: "~> 1.0"],
      deps_path: "deps/#{@target}",
      build_path: "_build/#{@target}",
      lockfile: "mix.lock.#{@target}",
      start_permanent: Mix.env() == :prod,
      aliases: [loadconfig: [&bootstrap/1]],
      deps: deps()
    ]
  end

  # Starting nerves_bootstrap adds the required aliases to Mix.Project.config()
  # Aliases are only added if MIX_TARGET is set.
  def bootstrap(args) do
    Application.start(:nerves_bootstrap)
    Mix.Task.run("loadconfig", args)
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {EyeFw.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nerves, "~> 1.0", runtime: false},
      {:shoehorn, "~> 0.2"},
      {:eye, path: "../eye"}
    ] ++ deps(@target)
  end

  # Specify target specific dependencies
  defp deps("host"), do: []
  defp deps(target) do
    [
      {:nerves_runtime, "~> 0.6.1"},
      {:nerves_init_gadget, github: "nerves-project/nerves_init_gadget", ref: "dhcp"}
    ] ++ system(target)
  end

  defp system("rpi0_zbar"), do: [{:nerves_system_rpi0_zbar, "~> 1.0.0", runtime: false}]
  defp system(target), do: Mix.raise("Unknown MIX_TARGET: #{target}")
end
