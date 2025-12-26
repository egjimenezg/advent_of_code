defmodule AdventOfCode2025.Day2 do
  def answer() do
    {:ok, product_ids} = File.read("priv/day2_2025_input.txt")

    find_invalid_ids(product_ids)
    |> Enum.sum()
  end

  def find_invalid_ids(product_ids) do
    product_ids
    |> String.split(",")
    |> Enum.reduce([], fn range, invalid_ids ->
      [from, to] = get_range(range)

      from..to
      |> Enum.filter(&invalid_id?/1)
      |> Enum.reduce(invalid_ids, fn invalid_id, ids ->
        [invalid_id | ids]
      end)
    end)
  end

  defp get_range(range) do
    range
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
  end

  def invalid_id?(id) do
    digits = to_digits(id)

    case is_even(length(digits)) do
      true -> validate_digits(digits)
      false -> false
    end
  end

  defp validate_digits(digits) do
    digits_length = length(digits)
    left = Enum.take(digits, div(digits_length, 2))
    right = Enum.take(digits, div(digits_length, 2) * -1)
    left == right
  end

  defp to_digits(number) do
    to_digits(number, [])
  end

  defp to_digits(number, digits) do
    remainder = rem(number, 10)

    case remainder do
      remainder when remainder == number ->
        [number | digits]

      _ ->
        to_digits(div(number, 10), [remainder | digits])
    end
  end

  defp is_even(value) do
    rem(value, 2) == 0
  end
end
