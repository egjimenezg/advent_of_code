defmodule AdventOfCode2025.Day1Test do
  use ExUnit.Case
  alias AdventOfCode2025.Day1

  test "rotate/2 moves the dial to the left and get the number of times it points to zero" do
    assert Day1.rotate("L68", {50, 0}) == {82, 1}
    assert Day1.rotate("L30", {52, 0}) == {22, 0}
    assert Day1.rotate("L5", {0, 0}) == {95, 0}
    assert Day1.rotate("L55", {55, 0}) == {0, 1}
    assert Day1.rotate("L1", {0, 0}) == {99, 0}
    assert Day1.rotate("L99", {99, 0}) == {0, 1}
    assert Day1.rotate("L250", {50, 0}) == {0, 3}
    assert Day1.rotate("L82", {14, 0}) == {32, 1}
    assert Day1.rotate("L125", {25, 2}) == {0, 4}
    assert Day1.rotate("L169", {31, 4}) == {62, 6}
    assert Day1.rotate("L100", {50, 1}) == {50, 2}
  end

  test "rotate/2 moves the dial to the right and get the number of times it points to zero" do
    assert Day1.rotate("R48", {52, 0}) == {0, 1}
    assert Day1.rotate("R60", {95, 0}) == {55, 1}
    assert Day1.rotate("R14", {0, 0}) == {14, 0}
    assert Day1.rotate("R100", {0, 0}) == {0, 1}
    assert Day1.rotate("R375", {25, 0}) == {0, 4}
    assert Day1.rotate("R1000", {50, 0}) == {50, 10}
    assert Day1.rotate("R1000", {50, 4}) == {50, 14}
  end
end
