defmodule Aoc.DayFour do

  def count_real_rooms(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&split/1)
    |> Enum.filter(&valid?/1)
    |> Enum.reduce(0, fn ({name, number, chksm}, acc) -> acc + number end)
  end

  def decrypt(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&split/1)
    |> Enum.map(&decrypt_name/1)
    |> Enum.map(&IO.inspect/1)
    nil
  end

  def split(string) do
    [_, room, number, checksum] = Regex.run(~r/(.*)-(\d+)\[(\w+)\]/, string)
    {room, String.to_integer(number), checksum}
  end

  def decrypt_name({name, number, chksm}) do
    String.split(name, "-", trim: true)
    |> Enum.map(&(String.split(&1, "", trim: true)))
    |> Enum.map(&(Enum.map(&1, fn c -> decrypt_char(c, number) end)))
    |> Enum.map(&List.to_string/1)
    |> Enum.reduce(&(&1 <> " " <> &2))
    |> Kernel.<>(" #{number}")
  end

  def decrypt_char(char, 0), do: char
  def decrypt_char(char, sector_id) do
    << codepoint::utf8 >> = char
    res = case codepoint do
      ?z -> "a"
      codepoint when codepoint in ?a..?y -> << codepoint+1 >>
      any -> any
    end
    decrypt_char(res, sector_id - 1)
  end

  def valid?({name, number, chksm}) do
    name
    |> String.split("-", trim: true)
    |> List.to_string
    |> String.split("", trim: true)
    |> Enum.reduce(%{}, fn(char, acc) -> Map.update(acc, char, 0, &(&1+1))  end)
    |> Enum.sort_by(fn ({char,count}) -> count end, &>=/2)
    |> Enum.map(&(elem(&1, 0)))
    |> Enum.take(5)
    |> List.to_string
    |> Kernel.==(chksm)
  end

end
