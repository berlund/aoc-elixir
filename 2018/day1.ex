defmodule Day1 do
    
    def part1() do
        freq = File.read!("day1.txt")
        |> String.split("\n")
        |> List.foldl(0, fn elem, acc -> acc + num(elem) end)
        
        IO.puts("The answer is #{freq}")
    end

    
    defp num("") do 0 end

    defp num(numStr) do
        String.to_integer(numStr)
    end

end