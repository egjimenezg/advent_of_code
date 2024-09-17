defmodule AdventOfCode2023.Day2 do
  def answer() do
    File.stream!("priv/day2_input.txt")
    |> Stream.map(&calculate_number_of_cubes_in_game/1)
    |> sum_valid_games()
  end

  def answer_part_2() do
    File.stream!("priv/day2_input.txt")
    |> Stream.map(&calculate_min_number_of_cubes_required/1)
    |> Enum.sum()
  end

  defp calculate_min_number_of_cubes_required(game) do
    subsets = String.replace(game, ~r/^Game \d+: /, "")

    cubes_by_color(subsets)
    |> Enum.reduce(%{}, fn subset, game_cubes ->
      Map.merge(game_cubes, subset, fn _k, v1, v2 ->
        max(v1, v2)
      end)
    end)
    |> Map.values()
    |> Enum.reduce(1, fn quantity, power ->
      power * quantity
    end)
  end

  def calculate_number_of_cubes_in_game(game) do
    [number, subsets] = String.split(game, ":")

    {number, _} =
      number
      |> String.replace("Game ", "")
      |> Integer.parse()

    cubes_by_color = cubes_by_color(subsets)

    {number, cubes_by_color}
  end

  defp cubes_by_color(subsets) do
    subsets
    |> String.split(";")
    |> Enum.map(fn subset ->
      String.split(subset, ",")
      |> Enum.map(&String.trim/1)
      |> Enum.into(%{}, fn number_and_color ->
        [_, number, color] = Regex.run(~r/(\d+) ([a-z]+)/, number_and_color)

        {color, elem(Integer.parse(number), 0)}
      end)
    end)
  end

  def sum_valid_games(games) do
    games
    |> Enum.reject(fn {_id, subsets} ->
      Enum.any?(subsets, fn cubes_by_color ->
        invalid_number?(cubes_by_color)
      end)
    end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  defp invalid_number?(cubes_by_color) do
    Map.get(cubes_by_color, "green", 0) > 13 or
      Map.get(cubes_by_color, "red", 0) > 12 or
      Map.get(cubes_by_color, "blue", 0) > 14
  end
end
