defmodule Day1Test do
  use ExUnit.Case

  test "first double frequency" do

    {freq, h} = [1, -2, 3, 1, 1, -2]
    |> Aoc2018.Day1.part2()

    IO.inspect(h)
    assert freq == 2
  end
end