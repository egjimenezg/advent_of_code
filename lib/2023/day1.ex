defmodule AdventOfCode2023.Day1 do
  def answer() do
    File.stream!("priv/day1_input.txt")
    |> Stream.map(&join_first_and_last_digit/1)
    |> Stream.map(&elem(Integer.parse(&1), 0))
    |> Enum.sum()
  end

  def join_first_and_last_digit(line) do
    digits =
      line
      |> String.to_charlist()
      |> Enum.filter(&(&1 >= 48 and &1 <= 57))
      |> to_string()

    digits
    |> String.first()
    |> Kernel.<>(String.last(digits))
  end
end
