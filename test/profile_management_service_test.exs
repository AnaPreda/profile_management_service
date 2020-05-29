defmodule ProfileManagementServiceTest do
  use ExUnit.Case
  doctest ProfileManagementService

  test "greets the world" do
    assert ProfileManagementService.hello() == :world
  end
end
