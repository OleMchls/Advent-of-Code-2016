defmodule Aoc.DayThree do

  def possible_triangles(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&(String.split(&1, " ", trim: true)))
    |> Enum.map(fn set -> Enum.map(set, &String.to_integer/1) end)
    |> Enum.chunk(3)
    |> Enum.reduce([], fn([[a1, b1, c1], [a2, b2, c2], [a3, b3, c3]], acc) -> [[a1, a2, a3], [b1, b2, b3], [c1, c2, c3] | acc] end)
    |> Enum.count(fn [a,b,c] -> is_treeangle?(a,b,c) end)
  end

  def is_treeangle?(a, b, c) when a + b > c and b + c > a and c + a > b, do: true
  def is_treeangle?(_, _, _), do: false

end
