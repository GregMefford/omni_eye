defmodule EyeUi.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom
  import_types EyeUi.Schema.CameraTypes
  import_types EyeUi.Schema.BarcodeTypes

  alias EyeUi.Resolvers

  query name: "Query" do

    @desc "Get current camera configuration"
    field :config, :camera_config do
      resolve &Resolvers.Camera.get_config/3
    end

    @desc "Get barcode scans from the most recent video frame"
    field :barcodes, list_of(:symbol) do
      resolve &Resolvers.Barcode.get_next_scan/3
    end

  end

  mutation name: "Mutation" do

    @desc "Set camera resolution"
    field :size, :camera_config do
      arg :width, non_null(:integer)
      arg :height, non_null(:integer)
      resolve &Resolvers.Camera.set_size/3
    end

    @desc "Set image effect"
    field :img_effect, :camera_config do
      arg :effect, :img_effect
      resolve &Resolvers.Camera.set_img_effect/3
    end

  end

  subscription name: "Subscription" do

    field :barcodes, list_of(:symbol) do
      config fn _args, _info ->
        {:ok, topic: "*"}
      end
    end

    field :config, :camera_config do
      config fn _args, _info ->
        {:ok, topic: "*"}
      end

      trigger :size, topic: fn _size -> "*" end
    end

  end

end
