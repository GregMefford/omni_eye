defmodule EyeUi.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom
  import_types EyeUi.Schema.CameraTypes

  alias EyeUi.Resolvers

  query name: "Query" do

    @desc "Get current camera configuration"
    field :config, :camera_config do
      resolve &Resolvers.Camera.get_config/3
    end

  end

  mutation name: "Mutation" do

    @desc "Set camera resolution"
    field :size, :camera_config do
      arg :width, non_null(:integer)
      arg :height, non_null(:integer)
      resolve &Resolvers.Camera.set_size/3
    end

  end

end
