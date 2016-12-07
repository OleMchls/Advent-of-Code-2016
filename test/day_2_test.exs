defmodule Aoc.DayTwoTest do
  use ExUnit.Case, async: true

  alias Aoc.DayTwo

  test "single key" do
    assert DayTwo.get_key("UL", 5) == 1
  end

  test "single key with invalid instruction" do
     assert DayTwo.get_key("ULL", 5) == 1
  end

  test "full instruction set" do
    instructions = """
    ULL
    RRDDD
    LURDL
    UUUUD
    """

    assert DayTwo.access_code(instructions) == 1985
  end
end
