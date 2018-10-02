defmodule Day1 do
  def solve(filename) do
    File.read!(filename)
    |> String.codepoints()
    |> List.foldl(0, fn n, s -> track(n, s) end)
  end

  def track(")", n) do n - 1 end
  def track("(", n) do n + 1 end

end

Day1.solve("data.txt")
|> IO.puts()
