defmodule Eye.Resolvers.Camera do

  def get_config(_parent, _args, _resolution) do
    {:ok, Eye.Camera.get_config()}
  end

  def set_size(_parent, args, _resolution) do
    Eye.Camera.set_size(args[:width], args[:height])
    {:ok, Eye.Camera.get_config()}
  end

end
