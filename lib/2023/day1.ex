defmodule AdventOfCode2023.Day1 do
  @numbers %{
    one: "1",
    two: "2",
    three: "3",
    four: "4",
    five: "5",
    six: "6",
    seven: "7",
    eight: "8",
    nine: "9"
  }

  def answer() do
    File.stream!("priv/day1_input.txt")
    |> Stream.map(&join_first_and_last_digit/1)
    |> Stream.map(&elem(Integer.parse(&1), 0))
    |> Enum.sum()
  end

  def join_first_and_last_digit(line) do
    digits =
      line
      |> String.to_charlist()
      |> Enum.with_index()
      |> Enum.filter(&(elem(&1, 0) >= ?0 and elem(&1, 0) <= ?9))
      |> Enum.map(fn {_, index} -> {index, 1} end)

    index_and_size_of_digits =
      @numbers
      |> Enum.reduce([], fn {key, _val}, list_of_positions ->
        regex = ~r/#{key}/

        case Regex.scan(regex, line, return: :index) do
          [] ->
            list_of_positions

          positions ->
            list_of_positions
            |> Enum.concat(List.flatten(positions))
        end
      end)
      |> Enum.concat(digits)
      |> Enum.sort()

    first_digit =
      index_and_size_of_digits
      |> hd()
      |> extract_digit_by_index(line)

    last_digit =
      index_and_size_of_digits
      |> List.last()
      |> extract_digit_by_index(line)

    "#{first_digit}#{last_digit}"
  end

  defp extract_digit_by_index({index, 1}, line) do
    String.at(line, index)
  end

  defp extract_digit_by_index({index, size}, line) do
    number = String.slice(line, index, size)
    Map.get(@numbers, String.to_existing_atom(number))
  end
end
