defmodule ContifyTest do
  use ExUnit.Case
  doctest Contify

  test "greets the world" do
    assert Contify.hello() == :world
  end
end
