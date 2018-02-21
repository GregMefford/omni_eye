defmodule EyeUi.Schema.BarcodeTypes do
  use Absinthe.Schema.Notation

  @desc "Barcode symbol"
  object :symbol do
    field :type, :string
    field :quality, :integer
    field :points, list_of(:point)
    field :data, :string
  end

  @desc "The X and Y offset from the top-left pixel of the image"
  object :point do
    field :x, :integer
    field :y, :integer
  end
end
