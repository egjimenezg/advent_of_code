defmodule AdventOfCode2025.Day1 do
  @initial_position {50, 0}

  def answer_day_1() do
    File.stream!("priv/day1_2025_input.txt")
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.scan(@initial_position, &rotate/2)
    |> Stream.filter(&(elem(&1, 0) == 0))
    |> Enum.count()
  end

  def answer_day_1_part_2() do
    File.stream!("priv/day1_2025_input.txt")
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.scan(@initial_position, &rotate/2)
    |> Enum.at(-1)
    |> elem(1)
  end

  def rotate(<<"L", distance::binary>>, {position, times_pointed_to_zero}) do
    distance = String.to_integer(distance)
    new_position = Integer.mod(position - distance, 100)

    times_pointed_to_zero =
      times_pointed_to_zero + count_times_pointed_to_zero("L", distance, position)

    {new_position, times_pointed_to_zero}
  end

  def rotate(<<"R", distance::binary>>, {position, times_pointed_to_zero}) do
    distance = String.to_integer(distance)
    new_position = Integer.mod(position + distance, 100)

    times_pointed_to_zero =
      times_pointed_to_zero + count_times_pointed_to_zero("R", distance, position)

    {new_position, times_pointed_to_zero}
  end

  defp count_times_pointed_to_zero(direction, distance, position) do
    remainder = rem(distance, 100)

    times_pointed_to_zero =
      case {direction, position} do
        {"L", position} when position != 0 and position - remainder <= 0 -> 1
        {"R", position} when position + remainder >= 100 -> 1
        _ -> 0
      end

    case distance do
      distance when distance >= 100 ->
        div(distance - remainder, 100)

      _ ->
        0
    end
    |> Kernel.+(times_pointed_to_zero)
  end
end
