defmodule AdventOfCode2023.Day2Test do
  use ExUnit.Case
  alias AdventOfCode2023.Day2

  test "group cubes number by color" do
    game = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
    game_cubes = Day2.calculate_number_of_cubes_in_game(game)

    assert {1,
            [
              %{"blue" => 3, "red" => 4},
              %{"red" => 1, "green" => 2, "blue" => 6},
              %{"green" => 2}
            ]} == game_cubes
  end

  test "sum ids of valid games" do
    games = [
      {1,
       [
         %{"blue" => 3, "red" => 4},
         %{"red" => 1, "green" => 2, "blue" => 6},
         %{"green" => 2}
       ]},
      {2,
       [
         %{"green" => 8, "blue" => 6, "red" => 20},
         %{"blue" => 5, "red" => 4, "green" => 13},
         %{"green" => 5, "red" => 1}
       ]}
    ]

    assert 1 == Day2.sum_valid_games(games)
  end
end
