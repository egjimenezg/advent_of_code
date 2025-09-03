defmodule AdventOfCode2024.Day4 do
  def answer() do
    File.stream!("priv/day4_input.txt")
    |> Stream.map(&get_winning_and_owned_numbers/1)
    |> Stream.map(&calculate_card_points/1)
    |> Enum.sum()
  end

  def get_winning_and_owned_numbers(line) do
    [winning_numbers, owned_numbers] = String.split(line, "|")

    winning_numbers =
      Regex.replace(~r/Card\s+\d+:/, winning_numbers, "")
      |> get_numbers_from_str()

    owned_numbers = get_numbers_from_str(owned_numbers)

    {winning_numbers, owned_numbers}
  end

  def calculate_card_points({winning_numbers, owned_numbers})
      when is_list(winning_numbers) and is_list(owned_numbers) do
    winning_numbers = MapSet.new(winning_numbers)
    owned_numbers = MapSet.new(owned_numbers)

    MapSet.intersection(winning_numbers, owned_numbers)
    |> MapSet.to_list()
    |> Enum.count()
    |> case do
      cards_number when cards_number > 0 ->
        2 ** (cards_number - 1)

      _ ->
        0
    end
  end

  defp get_numbers_from_str(str) when is_binary(str) do
    str
    |> String.trim()
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end
end
