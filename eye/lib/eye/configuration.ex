defmodule Eye.Configuration do
  @moduledoc """
  This camera configuration struct holds on to the current state of each
  `Picam` camera setting that the `Eye` application supports:

  * `size`: The image resolution as a map of `%{width: w, height: h}`.
  """

  defstruct [
    size: %{width: 1280, height: 720}
  ]

  @typedoc @moduledoc
  @type t ::
    %__MODULE__{
      size: dimensions()
    }

  @type dimensions ::
    %{width: non_neg_integer(), height: non_neg_integer()}

end
