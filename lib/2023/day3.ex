defmodule AdventOfCode2023.Day3 do
  def answer() do
    File.read!("priv/day3_input.txt")
    |> String.split("\n")
    |> build_matrix()
    |> find_part_numbers()
    |> Enum.sum()
  end

  def build_matrix(file_content) do
    matrix =
      for {file_line, row} <- Enum.with_index(file_content) do
        characters =
          file_line
          |> String.split("", trim: true)
          |> Enum.with_index()

        for {character, column} <- characters do
          {{row, column}, character}
        end
        |> Map.new()
      end
      |> Enum.reduce(%{}, &Map.merge(&1, &2))

    {matrix, file_content}
  end

  def find_part_numbers({matrix, file_content}) do
    reg_exp = ~r/\d+/

    file_content
    |> Enum.with_index()
    |> Enum.map(fn {line, row} ->
      {row, Regex.scan(reg_exp, line, return: :index)}
    end)
    |> Enum.reduce([], fn line_numbers, part_numbers ->
      {row, numbers} = line_numbers

      numbers
      |> Enum.filter(fn [{number_column, digits}] ->
        adjacent_to_symbol?({row, number_column, digits}, matrix)
      end)
      |> Enum.map(fn [{number_column, digits}] ->
        number_column..(number_column + digits - 1)
        |> Enum.map_join("", &Map.get(matrix, {row, &1}))
        |> String.to_integer()
      end)
      |> Enum.concat(part_numbers)
    end)
  end

  defp adjacent_to_symbol?({number_row, number_column, number_of_digits}, matrix) do
    (number_column - 1)..(number_column + number_of_digits)
    |> Enum.any?(fn column ->
      Enum.any?((number_row - 1)..(number_row + 1), fn row ->
        matrix
        |> Map.get({row, column})
        |> is_symbol()
      end)
    end)
  end

  defp is_symbol(nil), do: false
  defp is_symbol(character) when character == ".", do: false

  defp is_symbol(maybe_number) do
    Integer.parse(maybe_number)
    |> case do
      {_, ""} -> false
      :error -> true
    end
  end
end
