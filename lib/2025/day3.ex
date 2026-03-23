defmodule AdventOfCode2025.Day3 do
  defp read_input() do
    File.stream!("priv/day3_2025_input.txt")
    |> Stream.map(&String.replace(&1, "\n", ""))
  end

  def answer_part_1() do
    read_input()
    |> Stream.map(&max_joltage(&1, 2))
    |> Enum.sum()
  end

  def answer_part_2() do
    read_input()
    |> Stream.map(&max_joltage(&1, 12))
    |> Enum.sum()
  end

  defp parse_digits(bank) do
    bank
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def max_joltage(bank, n) do
    digits = parse_digits(bank)
    remaining_omits = length(digits) - n
    queue = :queue.new()

    {queue, _} =
      digits
      |> Enum.reduce({queue, remaining_omits}, fn digit, {queue, remaining_omits} ->
        select_max_digits(queue, digit, remaining_omits)
      end)

    :queue.to_list(queue)
    |> Enum.join()
    |> String.slice(0, n)
    |> String.to_integer()
  end

  defp select_max_digits(queue, digit, remaining_omits) do
    case {:queue.peek_r(queue), remaining_omits} do
      {:empty, _} ->
        {:queue.in(digit, queue), remaining_omits}

      {{:value, last}, remaining_omits} when remaining_omits == 0 or digit <= last ->
        {:queue.in(digit, queue), remaining_omits}

      _ ->
        drop_rear_while_gt(queue, digit, remaining_omits)
    end
  end

  def drop_rear_while_gt(queue, digit, remaining_omits) do
    case {:queue.peek_r(queue), remaining_omits} do
      {{:value, last}, remaining_omits} when digit > last and remaining_omits > 0 ->
        {_, queue} = :queue.out_r(queue)
        remaining_omits = remaining_omits - 1
        drop_rear_while_gt(queue, digit, remaining_omits)

      _ ->
        queue = :queue.in(digit, queue)
        {queue, remaining_omits}
    end
  end
end
