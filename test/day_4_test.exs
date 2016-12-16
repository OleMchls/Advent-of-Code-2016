defmodule Aoc.DayFourTest do
  use ExUnit.Case, async: true

  alias Aoc.DayFour

  test "examples" do
    input = """
    aaaaa-bbb-z-y-x-123[abxyz]
    a-b-c-d-e-f-g-h-987[abcde]
    not-a-real-room-404[oarel]
    totally-real-room-200[decoy]
    """
    assert DayFour.count_real_rooms(input) == 1514
  end
end
