defmodule ChronalCalibration do
  def final_frequency(input) do
    input
    |> parse_input()
    |> Enum.sum()
  end

  def repeated_frequency(input) do
    input
    |> parse_input()
    |> Stream.cycle()
    |> Enum.reduce_while({0, MapSet.new([0])}, fn x, {current_frequency, frequencies} ->
      frequency = current_frequency + x

      if MapSet.member?(frequencies, frequency) do
        {:halt, frequency}
      else
        {:cont, {frequency, MapSet.put(frequencies, frequency)}}
      end
     end)
  end

  defp parse_input(input) do
    input
    |> File.stream!()
    |> Stream.map(fn (line) ->
      {integer, _} = Integer.parse(line)
      integer
    end)
  end
end
