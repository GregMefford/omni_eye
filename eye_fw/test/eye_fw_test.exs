defmodule EyeFwTest do
  use ExUnit.Case
  doctest EyeFw

  test "greets the world" do
    assert EyeFw.hello() == :world
  end
end
