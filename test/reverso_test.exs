defmodule ReversoTest do
  use ExUnit.Case
  alias Echo.Reverso

  test "reverse string with reverso method" do

    assert Reverso.reverso("reverse\n") == "esrever\n"

    assert Reverso.reverso("reverse") == "esrever\n"

  end
end