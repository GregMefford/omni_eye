defmodule Eye.Camera do
  use GenServer
  alias Eye.Configuration
  require Logger

  # Public API

  def get_config(), do: GenServer.call(__MODULE__, :get_config)

  def set_size(width, height) do
    GenServer.call(__MODULE__, {:set_size, width, height})
  end

  def set_img_effect(effect) do
    GenServer.call(__MODULE__, {:set_img_effect, effect})
  end

  defdelegate next_frame(), to: Picam

  # GenServer API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    Logger.info("Configuring camera")
    conf = %Configuration{}
    Picam.set_size(conf.size.width, conf.size.height)
    Picam.set_img_effect(conf.img_effect)
    {:ok, conf}
  end

  def handle_call(:get_config, _from, conf), do: {:reply, conf, conf}

  def handle_call({:set_size, width, height}, _from, conf) do
    case Picam.set_size(width, height) do
      :ok ->
        if width > 1280 do
          Picam.set_quality(5)
        else
          Picam.set_quality(15)
        end
        conf = %{conf | size: %{width: width, height: height}}
        {:reply, :ok, conf}

      err ->
        {:reply, err, conf}
    end
  end

  def handle_call({:set_img_effect, effect}, _from, conf) do
    case Picam.set_img_effect(effect) do
      :ok ->
        conf = %{conf | img_effect: effect}
        {:reply, :ok, conf}

      err ->
        {:reply, err, conf}
    end
  end

end
