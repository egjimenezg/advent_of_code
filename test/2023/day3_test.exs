defmodule AdventOfCode2023.Day3Test do
  use ExUnit.Case
  alias AdventOfCode2023.Day3

  test "build a character matrix from the contents of the file" do
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

  describe "part numbers" do
    test "find_part_numbers_and_gears/1 should return the part numbers in the file" do
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

      assert %{part_numbers: [467]} = Day3.find_part_numbers_and_gears({matrix, file_content})
    end

    test "find_part_numbers_and_gears/1 should return the gears" do
      file_content = [
        "467.",
        "...*.",
        "..35"
      ]

      {matrix, _} = Day3.build_matrix(file_content)

      assert %{gears: [[35, 467]], part_numbers: [35, 467]} ==
               Day3.find_part_numbers_and_gears({matrix, file_content})
    end
  end
end
