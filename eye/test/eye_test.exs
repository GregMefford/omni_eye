defmodule EyeTest do
  use ExUnit.Case
  doctest Eye

  test "greets the world" do
    assert Eye.hello() == :world
  end
end
