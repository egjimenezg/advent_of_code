defmodule AdventOfCode2023.Day4Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day4

  test "parses card data to return winning and owned numbers" do
    card = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"

    %{winning_numbers: winning_numbers, owned_numbers: owned_numbers} =
      Day4.get_winning_and_owned_numbers(card)

    assert winning_numbers == [41, 48, 83, 86, 17]
    assert owned_numbers == [83, 86, 6, 31, 17, 9, 48, 53]
  end

  test "should calculates number of copies won" do
    card_number = 1
    winning_numbers = [41, 48, 83, 86, 17]
    owned_numbers = [83, 86, 6, 31, 17, 9, 48, 53]

    %{card_number: card_number, copies_won: copies_won} =
      Day4.calculate_number_of_copies_won(%{
        card_number: card_number,
        winning_numbers: winning_numbers,
        owned_numbers: owned_numbers
      })

    assert card_number == 1
    assert copies_won == 4
  end

  test "should get the card copies" do
    card_copies = Day4.get_card_copies(%{card_number: 1, copies_won: 4})
    assert match?({1, %{2 => 1, 3 => 1, 4 => 1, 5 => 1}}, card_copies)
  end
end
