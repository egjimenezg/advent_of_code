defmodule AdventOfCode2023.Day3 do
  def answer() do
    %{part_numbers: part_numbers, gears: gears} =
      File.read!("priv/day3_input.txt")
      |> String.split("\n")
      |> build_matrix()
      |> find_part_numbers_and_gears()

    {Enum.sum(part_numbers), add_up_gear_ratios(gears)}
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

  def find_part_numbers_and_gears({matrix, file_content}) do
    reg_exp = ~r/\d+/

    %{part_numbers: part_numbers, gears: gears} =
      file_content
      |> Stream.with_index()
      |> Stream.map(fn {line, row} ->
        {row, Regex.scan(reg_exp, line, return: :index)}
      end)
      |> Enum.reduce(%{part_numbers: [], gears: %{}}, fn {row, numbers}, part_numbers_and_gears ->
        line_numbers_and_gears =
          numbers
          |> Stream.map(fn [{column, digits}] ->
            part_number = get_part_number_from_matrix(row, column, digits, matrix)
            adjacent_symbols = find_adjacent_symbols(row, column, digits, matrix)
            {part_number, adjacent_symbols}
          end)
          |> Stream.filter(fn
            {_, []} -> false
            _ -> true
          end)
          |> Enum.reduce(%{part_numbers: [], gears: %{}}, fn {part_number, adjacent_symbols},
                                                             part_numbers_and_gears_in_line ->
            adjacent_gears =
              Enum.filter(adjacent_symbols, &(Map.get(matrix, &1) == "*"))
              |> Enum.map(fn row_column -> {row_column, [part_number]} end)
              |> Map.new()

            part_numbers_and_gears_in_line
            |> Map.update!(:part_numbers, fn part_numbers ->
              [part_number | part_numbers]
            end)
            |> Map.update!(:gears, fn gears_in_line ->
              Map.merge(gears_in_line, adjacent_gears, fn _k, v1, v2 -> v1 ++ v2 end)
            end)
          end)

        part_numbers_and_gears
        |> Map.update!(:part_numbers, fn part_numbers ->
          line_numbers_and_gears
          |> Map.get(:part_numbers)
          |> Enum.concat(part_numbers)
        end)
        |> Map.update!(:gears, fn gears ->
          line_numbers_and_gears
          |> Map.get(:gears)
          |> Map.merge(gears, fn _k, v1, v2 -> v1 ++ v2 end)
        end)
      end)

    gears =
      Map.values(gears)
      |> Enum.filter(fn gear -> length(gear) == 2 end)

    %{part_numbers: part_numbers, gears: gears}
  end

  defp find_adjacent_symbols(number_row, number_column, digits, matrix) do
    columns = (number_column - 1)..(number_column + digits)

    Enum.reduce(columns, [], fn column, symbols ->
      rows = (number_row - 1)..(number_row + 1)

      Stream.filter(rows, fn row ->
        matrix
        |> Map.get({row, column})
        |> symbol?()
      end)
      |> Stream.map(fn row -> {row, column} end)
      |> Enum.concat(symbols)
    end)
  end

  defp symbol?(nil), do: false
  defp symbol?(character) when character == ".", do: false

  defp symbol?(maybe_number) do
    Integer.parse(maybe_number)
    |> case do
      {_, ""} -> false
      :error -> true
    end
  end

  defp get_part_number_from_matrix(row, column, digits, matrix) do
    column..(column + digits - 1)
    |> Enum.map_join("", &Map.get(matrix, {row, &1}))
    |> String.to_integer()
  end

  defp add_up_gear_ratios(gears) do
    Enum.reduce(gears, 0, fn gear, gear_ratios_sum ->
      [part_num_a, part_num_b] = gear
      gear_ratios_sum + part_num_a * part_num_b
    end)
  end
end
