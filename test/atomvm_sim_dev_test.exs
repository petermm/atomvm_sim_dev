defmodule AtomvmSimDevTest do
  use ExUnit.Case
  doctest AtomvmSimDev

  test "greets the world" do
    assert AtomvmSimDev.hello() == :world
  end
end
