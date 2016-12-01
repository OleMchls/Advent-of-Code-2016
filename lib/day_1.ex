defmodule Aoc.DayOne do

  defstruct [direction: :north, x: 0, y: 0, history: []]

  def distance(directions) do
    parse(directions)
    |> walk(%Aoc.DayOne{})
    |> calculate_distance
  end

  def first_duplicate_distance(directions) do
    parse(directions)
    |> walk(%Aoc.DayOne{})
    |> find_first_duplicate(nil)
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

  defp progress(state, 0), do: state
  defp progress(state, distance) do
    state = %{state | history: state.history ++ [{state.x, state.y}] }
    case state.direction do
      :north -> %{state | y: state.y + 1 }
      :east -> %{state | x: state.x + 1 }
      :south -> %{state | y: state.y - 1 }
      :west -> %{state | x: state.x - 1 }
    end
    |> progress(distance - 1)
  end

  defp find_first_duplicate(%Aoc.DayOne{history: [current | history]} = state, nil) do
    find_first_duplicate(%{state | history: history }, Enum.find(history, &(&1 == current)))
  end
  defp find_first_duplicate(_, match), do: match

  defp calculate_distance(%Aoc.DayOne{} = state), do: calculate_distance({state.x, state.y})
  defp calculate_distance({x, y}), do: abs(x) + abs(y)
end
