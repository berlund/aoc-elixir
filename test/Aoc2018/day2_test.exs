defmodule Day2Test do
  use ExUnit.Case

  alias Aoc2018.Day2

  test "correct checksum" do

    # this data given
    data = ["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"]

    # should give 4 * 3 = 12
    assert Day2.checksum_parts(data) == {4, 3}
  end

  test "counts duplicates" do
    assert Day2.count_dups_and_triplets("bababc") == {true, true}
    assert Day2.count_dups_and_triplets("abcdee") == {true, false}
    assert Day2.count_dups_and_triplets("abcccd") == {false, true}
    assert Day2.count_dups_and_triplets("abcccdd") == {true, true}
  end

  test "gets common parts" do
    assert Day2.common_parts("fghij", "fguij") == "fgij"
  end

  test "find match" do
    data = ["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"]

    result = Day2.find_match("", data)
    IO.inspect()
  end
end