defmodule AdventOfCode2023.Day1Test do
  use ExUnit.Case

  test "extract first and last digit of each line and form a single two digit number" do
    lines = [
      {"1abc2", "12"},
      {"pqr3stu8vwx", "38"},
      {"a1b2c3d4e5f", "15"},
      {"treb7uchet", "77"}
    ]

    for {line, two_digit_number} <- lines do
      assert two_digit_number == AdventOfCode2023.Day1.join_first_and_last_digit(line)
    end
  end

end
