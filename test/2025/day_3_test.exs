defmodule AdventOfCode2025.Day3Test do
  use ExUnit.Case, async: true
  alias AdventOfCode2025.Day3

  test "max_joltage/2 returns the max joltage obtained from turning on 2 batteries" do
    for {max_joltage, bank} <- [
          {98, "987654321111111"},
          {89, "811111111111119"},
          {78, "234234234234278"},
          {92, "818181911112111"},
          {99,
           "6999989789859986898999698988899978888978599996857879997869999878799989798999597847657999979799999899"},
          {76, "15721363520"}
        ] do
      assert max_joltage == Day3.max_joltage(bank, 2)
    end
  end

  test "max_joltage/2 returns the max joltage obtained from turning on 12 batteries" do
    for {max_joltage, bank} <- [
          {434_234_234_278, "234234234234278"},
          {811_111_111_119, "811111111111119"},
          {434_234_234_278, "234234234234278"},
          {888_911_112_111, "818181911112111"}
        ] do
      assert max_joltage == Day3.max_joltage(bank, 12)
    end
  end
end
