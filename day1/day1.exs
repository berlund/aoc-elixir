defmodule Day1 do
  def part1(filename) do
    File.read!(filename)
    |> String.codepoints()
    |> List.foldl(0, fn n, s -> track(n, s) end)
  end

  def track(")", n) do n - 1 end
  def track("(", n) do n + 1 end

  def part2(filename) do
    File.read!(filename)
    |> String.codepoints()
    |> List.foldl({0,0}, fn n, acc -> count_steps(n, acc) end)
  end

  # Takeaway: Order defines precedence for binding
  # Question: Would it be possible to break the map folding instead of running this
  # binding for the remainder of the list?
  def count_steps(_, {-1, count}) do
    {-1, count}
  end

  def count_steps(")", {level, count}) do
    {level - 1, count + 1}
  end

  def count_steps("(", {level, count}) do
    {level + 1, count + 1}
  end

end

solution1 = Day1.part1("data.txt")
{_, solution2} = Day1.part2("data.txt")

IO.puts("Day 1, part 1: #{solution1}, part 2: #{solution2}")
