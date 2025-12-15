defmodule AdventOfCode2025.Day1 do
  @initial_position {50, 0}

  def answer_day_1() do
    File.stream!("priv/day1_2025_input.txt")
    |> Enum.map(&String.replace(&1, "\n", ""))
    |> Stream.scan(@initial_position, &rotate/2)
    |> Stream.filter(&(elem(&1, 0) == 0))
    |> Enum.count()
  end

  def answer_day_1_part_2() do
    File.stream!("priv/day1_2025_input.txt")
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.scan(@initial_position, &rotate/2)
    |> Enum.to_list()
    |> Enum.reverse()
    |> hd()
    |> elem(1)
  end

  def rotate(rotation, {position, times_pointed_at_zero}) do
    <<direction::binary-size(1), distance::binary>> = rotation
    distance = String.to_integer(distance)
    remainder = rem(distance, 100)

    times_pointed_at_zero =
      case distance do
        distance when distance >= 100 ->
          times_pointed_at_zero + div(distance - remainder, 100)

        _ ->
          times_pointed_at_zero
      end

    times_pointed_at_zero =
      case {direction, position} do
        {"L", 0} -> times_pointed_at_zero
        {"L", position} when position - remainder <= 0 -> times_pointed_at_zero + 1
        {"R", position} when position + remainder >= 100 -> times_pointed_at_zero + 1
        {_, _} -> times_pointed_at_zero
      end

    new_position =
      case direction do
        "L" -> modulo(position - distance, 100)
        "R" -> modulo(position + distance, 100)
      end

    {new_position, times_pointed_at_zero}
  end

  defp modulo(x, y) do
    remainder = rem(x, y)

    case remainder do
      remainder when remainder < 0 ->
        remainder + y

      _ ->
        remainder
    end
  end
end
