defmodule EyeUi.Publisher do

  def publish(obj, topic) do
    Absinthe.Subscription.publish(EyeUiWeb.Endpoint, obj, topic)
  end

end
