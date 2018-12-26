defmodule BoxIdTest do
  use ExUnit.Case, async: true

  test "closest" do
    box_ids = ["abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz"]

    assert BoxId.closest(box_ids) == "fgij"
  end

  test "counts occurrences" do
    no_word = ""
    box_id1 = "abcdef"
    box_id2 = "bababc"

    assert BoxId.count_occurrences(no_word) == %{}

    assert BoxId.count_occurrences(box_id1) == %{
             ?a => 1,
             ?b => 1,
             ?c => 1,
             ?d => 1,
             ?e => 1,
             ?f => 1
           }

    assert BoxId.count_occurrences(box_id2) == %{?a => 2, ?b => 3, ?c => 1}
  end

  test "checksum" do
    box_ids = ["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"]

    assert BoxId.checksum(box_ids) == 12
  end
end
