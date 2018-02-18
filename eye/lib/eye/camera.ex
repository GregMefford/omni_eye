defmodule Eye.Camera do
  require Logger

  def configure do
    Logger.info("Configuring camera")
    Picam.set_quality(10)
    Picam.set_size(1280, 720)
    Picam.set_fps(30)
  end

  def next_frame do
    Picam.next_frame()
  end

end
