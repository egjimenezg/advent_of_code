defmodule AdventOfCode2023.Day4 do
  def answer() do
    File.stream!("priv/day4_input.txt")
    |> Stream.map(&get_winning_and_owned_numbers/1)
    |> Stream.map(&calculate_number_of_copies_won/1)
    |> Stream.map(&get_card_copies/1)
    |> Enum.reduce(%{}, fn {card_number, items}, acc ->
      Map.put(acc, card_number, items)
    end)
    |> count_cards()
  end

  def sum_values(card_number, cards, memory) do
    case Map.get(memory, card_number) do
      nil ->
        Map.get(cards, card_number)
        |> case do
          card_copies when map_size(card_copies) == 0 ->
            {Map.put(memory, card_number, 0), 0}

          card_copies ->
            values_sum =
              card_copies
              |> Map.values()
              |> Enum.sum()

            {memory, total} =
              card_copies
              |> Enum.reduce({memory, 0}, fn {k, _}, {memory, acc} ->
                {memory, value} = sum_values(k, cards, memory)
                {memory, acc + value}
              end)

            total = total + values_sum
            {Map.put(memory, card_number, total), total}
        end

      value ->
        {memory, value}
    end
  end

  def count_cards(cards) do
    numbers = Map.keys(cards)

    {sum, _} =
      numbers
      |> Enum.reduce({0, %{}}, fn card_number, {acc, memory} ->
        {memory, value} = sum_values(card_number, cards, memory)
        {acc + value, memory}
      end)

    sum + length(numbers)
  end

  def get_winning_and_owned_numbers(line) do
    [winning_numbers, owned_numbers] = String.split(line, "|")
    [card_number] = Regex.run(~r/\d+/, winning_numbers)

    winning_numbers =
      Regex.replace(~r/Card\s+\d+:/, winning_numbers, "")
      |> get_numbers_from_str()

    owned_numbers = get_numbers_from_str(owned_numbers)

    %{
      card_number: String.to_integer(card_number),
      winning_numbers: winning_numbers,
      owned_numbers: owned_numbers
    }
  end

  def calculate_number_of_copies_won(%{
        card_number: card_number,
        winning_numbers: winning_numbers,
        owned_numbers: owned_numbers
      }) do
    winning_numbers = MapSet.new(winning_numbers)
    owned_numbers = MapSet.new(owned_numbers)

    copies_won =
      MapSet.intersection(winning_numbers, owned_numbers)
      |> MapSet.to_list()
      |> Enum.count()

    %{card_number: card_number, copies_won: copies_won}
  end

  def get_card_copies(%{card_number: card_number, copies_won: copies_won}) do
    copies =
      case copies_won do
        copies_won when copies_won > 0 ->
          (card_number + 1)..(card_number + copies_won)
          |> Enum.reduce(%{}, fn elem, acc -> Map.put(acc, elem, 1) end)

        _ ->
          %{}
      end

    {card_number, copies}
  end

  defp get_numbers_from_str(str) when is_binary(str) do
    str
    |> String.trim()
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end
end
