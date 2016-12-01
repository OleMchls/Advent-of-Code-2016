defmodule Aoc.DayOneTest do
  use ExUnit.Case, async: true

  alias Aoc.DayOne

  test "simpel route" do
    assert DayOne.distance("R2, L3") == 5
  end

  test "circle route" do
    assert DayOne.distance("R2, R2, R2") == 2
  end

  test "long route" do
    assert DayOne.distance("R5, L5, R5, R3") == 12
  end
end
