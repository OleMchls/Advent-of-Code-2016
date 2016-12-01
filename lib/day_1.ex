defmodule Aoc.DayOne do

  defstruct [direction: :north, x: 0, y: 0]

  def distance(directions) do
    parse(directions)
    |> walk(%Aoc.DayOne{})
    |> calculate_distance
  end

  defp parse(direction) do
    String.split(direction, ",", trim: true)
    |> Enum.map(&String.trim/1)
  end

  defp walk(["R" <> distrance | directions], state) do
    distance = String.to_integer(distrance)
    state = case state.direction do
      :north -> %{state | direction: :east }
      :east -> %{state | direction: :south }
      :south -> %{state | direction: :west }
      :west -> %{state | direction: :north }
    end

    walk(directions, progress(state, distance))
  end

  defp walk(["L" <> distrance | directions], state) do
    distance = String.to_integer(distrance)
    state = case state.direction do
      :north -> %{state | direction: :west }
      :east -> %{state | direction: :north }
      :south -> %{state | direction: :east }
      :west -> %{state | direction: :south }
    end

    walk(directions, progress(state, distance))
  end

  defp walk([], state), do: state

  defp progress(state, distance) do
    case state.direction do
      :north -> %{state | y: state.y + distance }
      :east -> %{state | x: state.x + distance }
      :south -> %{state | y: state.y - distance }
      :west -> %{state | x: state.x - distance }
    end
  end

  defp calculate_distance(state) do
    abs(state.x) + abs(state.y)
  end
end
