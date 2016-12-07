defmodule Aoc.DayThreeTest do
  use ExUnit.Case, async: true

  alias Aoc.DayThree

  test "valid triangle" do
    assert DayThree.is_treeangle? 20, 20, 20
  end

  test "invalid triangle" do
    refute DayThree.is_treeangle? 5, 10, 25
  end
end
