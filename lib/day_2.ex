defmodule Aoc.DayTwo do

  def access_code(instructions) do
    instructions
    |> String.split("\n", trim: true)
    |> Enum.reduce([], fn(instruction, acc) -> [get_key(instruction, List.first(acc) || 5) | acc]  end)
    |> Enum.reverse
    |> Integer.undigits
  end

  def complex_access_code(instructions) do
    instructions
    |> String.split("\n", trim: true)
    |> Enum.reduce([], fn(instruction, acc) -> [get_complex_key(instruction, List.first(acc) || 5) | acc]  end)
    |> Enum.reverse
    |> Enum.map(&(Integer.to_string(&1, 16)))
    |> Enum.join
  end

  def get_key(instruction, startkey \\ 5) do
    walk_pad(String.split(instruction, "", trim: true), startkey)
  end

  def get_complex_key(instruction, startkey \\ 5) do
    walk_complex_pad(String.split(instruction, "", trim: true), startkey)
  end

  def walk_pad([], current), do: current
  def walk_pad(["R" | rest], n) when n in [1, 2, 4, 5, 8, 7], do: walk_pad(rest, n + 1)
  def walk_pad(["L" | rest], n) when n in [2, 3, 5, 6, 8, 9], do: walk_pad(rest, n - 1)
  def walk_pad(["U" | rest], n) when n in [4, 5, 6, 7, 8, 9], do: walk_pad(rest, n - 3)
  def walk_pad(["D" | rest], n) when n in [1, 2, 3, 4, 5, 6], do: walk_pad(rest, n + 3)
  def walk_pad([_ | rest], n), do: walk_pad(rest, n)

  def walk_complex_pad([], current), do: current
  def walk_complex_pad(["R" | rest], n) when n in [2, 3, 5, 6, 7, 8, 0xA, 0xB], do: walk_complex_pad(rest, n + 1)
  def walk_complex_pad(["L" | rest], n) when n in [3, 4, 6, 7, 8, 9, 0xB, 0xC], do: walk_complex_pad(rest, n - 1)
  def walk_complex_pad(["U" | rest], n) when n in [3, 0xD], do: walk_complex_pad(rest, n - 2)
  def walk_complex_pad(["U" | rest], n) when n in [0xA, 0xB, 0xC, 6, 7, 8], do: walk_complex_pad(rest, n - 4)
  def walk_complex_pad(["D" | rest], n) when n in [1, 0xB], do: walk_complex_pad(rest, n + 2)
  def walk_complex_pad(["D" | rest], n) when n in [2, 3, 4, 6, 7, 8], do: walk_complex_pad(rest, n + 4)
  def walk_complex_pad([_ | rest], n), do: walk_complex_pad(rest, n)
end
