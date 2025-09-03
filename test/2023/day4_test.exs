defmodule AdventOfCode2024.Day4Test do
  use ExUnit.Case

  alias AdventOfCode2024.Day4

  test "parses card data to return winning and owned numbers" do
    card = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"
    {winning_numbers, owned_numbers} = Day4.get_winning_and_owned_numbers(card)
    assert winning_numbers == [41, 48, 83, 86, 17]
    assert owned_numbers == [83, 86, 6, 31, 17, 9, 48, 53]
  end

  test "calculates card points" do
    winning_numbers = [41, 48, 83, 86, 17]
    owned_numbers = [83, 86, 6, 31, 17, 9, 48, 53]
    card_points = Day4.calculate_card_points({winning_numbers, owned_numbers})
    assert card_points == 8
  end
end
