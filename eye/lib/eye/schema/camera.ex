defmodule Eye.Schema.CameraTypes do
  use Absinthe.Schema.Notation

  @desc "Camera configuration"
  object :camera_config do
    field :size, :dimensions
  end

  @desc "Image dimensions"
  object :dimensions do
    field :width, :integer
    field :height, :integer
  end
end
