defmodule AdventOfCode2023.Day3Test do
  use ExUnit.Case
  alias AdventOfCode2023.Day3

  test "build characters matrix from file content" do
    file_content = ["467..114.."]
    matrix = Day3.build_matrix(file_content)

    assert match?(
             {%{
                {0, 0} => "4",
                {0, 1} => "6",
                {0, 2} => "7",
                {0, 3} => ".",
                {0, 4} => ".",
                {0, 5} => "1",
                {0, 6} => "1",
                {0, 7} => "4",
                {0, 8} => ".",
                {0, 9} => "."
              }, _},
             matrix
           )
  end

  test "find_part_numbers/1 should returns the part numbers in the file" do
    file_content = [
      "467..114..",
      "...*......"
    ]

    matrix = %{
      {0, 0} => "4",
      {0, 1} => "6",
      {0, 2} => "7",
      {0, 3} => ".",
      {0, 4} => ".",
      {0, 5} => "1",
      {0, 6} => "1",
      {0, 7} => "4",
      {0, 8} => ".",
      {0, 9} => ".",
      {1, 0} => ".",
      {1, 1} => ".",
      {1, 2} => ".",
      {1, 3} => "*",
      {1, 4} => ".",
      {1, 5} => ".",
      {1, 6} => ".",
      {1, 7} => ".",
      {1, 8} => ".",
      {1, 9} => "."
    }

    assert [467] == Day3.find_part_numbers({matrix, file_content})
  end
end
