defmodule AdventOfCode2025.Day2Test do
  use ExUnit.Case, async: true
  alias AdventOfCode2025.Day2

  for {id, is_invalid} <- [
        {123_123, true},
        {101, false},
        {565_655, false},
        {111, true},
        {123_123_123, true},
        {234_234_22, false},
        {858_666, false}
      ] do
    test "invalid_id?/1 should check whether the product id #{id} is invalid or not" do
      assert Day2.invalid_id?(unquote(id)) == unquote(is_invalid)
    end
  end
end
