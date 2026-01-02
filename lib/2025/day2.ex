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
    id = Integer.to_string(id)
    id_length = String.length(id)
    table = longest_prefix_suffix_table(id)

    longest_prefix_suffix_length = Map.get(table, id_length)

    case longest_prefix_suffix_length do
      0 ->
        false

      _ ->
        digit_block_length = id_length - longest_prefix_suffix_length
        rem(id_length, digit_block_length) == 0
    end
  end

  defp longest_prefix_suffix_table(pattern) do
    m = String.length(pattern)

    pattern =
      pattern
      |> String.to_charlist()
      |> Stream.with_index()
      |> Map.new(fn {c, index} -> {index, c} end)

    Map.new(0..m, fn n -> {n, 0} end)
    |> Map.put(0, -1)
    |> build_table(pattern, m)
  end

  def build_table(back_table, pattern, pattern_length) do
    build_table(back_table, pattern, pattern_length, {0, -1})
  end

  def build_table(back_table, pattern, pattern_length, {scan_index, border_length})
      when scan_index < pattern_length do
    border_length = update_border_length(back_table, pattern, {scan_index, border_length})
    border_length = border_length + 1
    scan_index = scan_index + 1

    build_table(
      Map.put(back_table, scan_index, border_length),
      pattern,
      pattern_length,
      {scan_index, border_length}
    )
  end

  def build_table(back_table, _, _, _), do: back_table

  def update_border_length(back_table, pattern, {scan_index, border_length})
      when border_length >= 0 do
    case {Map.get(pattern, scan_index), Map.get(pattern, border_length)} do
      {character, character} ->
        border_length

      _ ->
        border_length = Map.get(back_table, border_length)
        update_border_length(back_table, pattern, {scan_index, border_length})
    end
  end

  def update_border_length(_, _, {_, border_length}), do: border_length
end
