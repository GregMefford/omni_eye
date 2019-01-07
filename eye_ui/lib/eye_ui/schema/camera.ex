defmodule EyeUi.Schema.CameraTypes do
  use Absinthe.Schema.Notation

  @desc "Camera configuration"
  object :camera_config do
    field :size, :dimensions
    field :img_effect, :img_effect
  end

  @desc "Image dimensions"
  object :dimensions do
    field :width, :integer
    field :height, :integer
  end

  @desc "Image Effects"
  enum :img_effect do
    value :normal, as: :none, description: "No special effects"
    value :sketch, as: :sketch, description: "Just like at the amusement park"
    value :oilpaint, as: :oilpaint, description: "Just like Van Gogh"
  end
end
