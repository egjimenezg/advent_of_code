defmodule AdventOfCode2025.Day3 do
  @base 10

  def answer_part_1() do
    File.stream!("priv/day3_2025_input.txt")
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.map(&max_joltage/1)
    |> Enum.sum()
  end

  def max_joltage(bank) do
    [first_digit | digits] =
      bank
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)

    digits
    |> Enum.with_index()
    |> Enum.reduce(first_digit, fn {digit, index}, max_joltage ->
      update_max_joltage(max_joltage, digit, index == length(digits) - 1)
    end)
  end

  defp update_max_joltage(max_joltage, digit, last_battery?)
       when max_joltage < @base and not last_battery? do
    case {max_joltage, digit} do
      {max_joltage, digit} when max_joltage < digit ->
        digit

      _ ->
        max_joltage * 10 + digit
    end
  end

  defp update_max_joltage(max_joltage, digit, _) when max_joltage < @base do
    max_joltage * 10 + digit
  end

  defp update_max_joltage(max_joltage, digit, last_battery?) do
    battery_a = div(max_joltage, @base)
    battery_b = rem(max_joltage, @base)

    case {digit, battery_a, battery_b} do
      {digit, battery_a, _} when digit > battery_a and not last_battery? -> digit
      {digit, battery_a, battery_b} when digit > battery_b -> battery_a * @base + digit
      _ -> max_joltage
    end
  end
end
