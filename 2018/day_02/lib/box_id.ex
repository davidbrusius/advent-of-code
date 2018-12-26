# For example, if you see the following box IDs:

# abcdef contains no letters that appear exactly two or three times.
# bababc contains two a and three b, so it counts for both.
# abbcde contains two b, but no letter appears exactly three times.
# abcccd contains three c, but no letter appears exactly two times.
# aabcdd contains two a and two d, but it only counts once.
# abcdee contains two e.
# ababab contains three a and three b, but it only counts once.
# Of these box IDs, four of them contain a letter which appears exactly twice, and three of them contain a letter which appears exactly three times. Multiplying these together produces a checksum of 4 * 3 = 12.

# What is the checksum for your list of box IDs?

defmodule BoxId do
  def closest(box_ids) do
    box_ids
    |> Enum.map(&String.to_charlist/1)
    |> one_char_difference_string()
  end

  def one_char_difference_string([head | tail]) do
    if closest = Enum.find(tail, &one_char_difference_string(&1, head)) do
      head
      |> Enum.zip(closest)
      |> Enum.filter(fn {cp1, cp2} -> cp1 == cp2 end)
      |> Enum.map(fn {cp, _} -> cp end)
      |> List.to_string()
    else
      one_char_difference_string(tail)
    end
  end

  def one_char_difference_string(charlist1, charlist2) do
    charlist1
    |> Enum.zip(charlist2)
    |> Enum.count(fn {cp1, cp2} -> cp1 != cp2 end)
    |> Kernel.==(1)
  end

  def checksum(box_ids) do
    {twice, thrice} =
      box_ids
      |> Enum.reduce({0, 0}, fn word, {twice, thrice} ->
        {word_twice, word_thrice} =
          word
          |> count_occurrences
          |> twice_and_thrice_occurrencies

        {twice + word_twice, thrice + word_thrice}
      end)

    twice * thrice
  end

  def twice_and_thrice_occurrencies(occurrences) do
    twice = Enum.count(occurrences, fn {_codepoint, count} -> count == 2 end)
    thrice = Enum.count(occurrences, fn {_codepoint, count} -> count == 3 end)
    {min(twice, 1), min(thrice, 1)}
  end

  def count_occurrences(_box_id, acc \\ %{})

  def count_occurrences(<<>>, acc), do: acc

  def count_occurrences(<<codepoint::utf8, rest::binary>>, acc) do
    acc = Map.update(acc, codepoint, 1, &(&1 + 1))
    count_occurrences(rest, acc)
  end
end
