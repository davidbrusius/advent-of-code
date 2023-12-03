defmodule Day02.Game do
  alias Day02.Game.Set

  defstruct id: nil, sets: [%Set{}], power: 0

  def to_struct(game) do
    [<<"Game ", id::binary>>, rest] = String.split(game, ":")
    sets = String.split(rest, ";")

    %__MODULE__{
      id: String.to_integer(id),
      sets: Enum.map(sets, &struct(Set, parse_set(&1)))
    }
  end

  defp parse_set(set) when is_binary(set) do
    set
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, " "))
    |> Map.new(fn [count, color] ->
      {String.to_existing_atom(color), String.to_integer(count)}
    end)
  end
end
