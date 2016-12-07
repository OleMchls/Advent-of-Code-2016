defmodule Aoc.DayTwo do

  def access_code(instructions) do
    instructions
    |> String.split("\n", trim: true)
    |> Enum.reduce([], fn(instruction, acc) -> [get_key(instruction, List.first(acc) || 5) | acc]  end)
    |> Enum.reverse
    |> Integer.undigits
  end

  def get_key(instruction, startkey \\ 5) do
    walk_pad(String.split(instruction, "", trim: true), startkey)
  end

  def walk_pad([], current), do: current
  def walk_pad(["R" | rest], n) when n in [1, 2, 4, 5, 8, 7], do: walk_pad(rest, n + 1)
  def walk_pad(["L" | rest], n) when n in [2, 3, 5, 6, 8, 9], do: walk_pad(rest, n - 1)
  def walk_pad(["U" | rest], n) when n in [4, 5, 6, 7, 8, 9], do: walk_pad(rest, n - 3)
  def walk_pad(["D" | rest], n) when n in [1, 2, 3, 4, 5, 6], do: walk_pad(rest, n + 3)
  def walk_pad([_ | rest], n), do: walk_pad(rest, n)
end
