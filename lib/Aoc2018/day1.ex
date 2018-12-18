defmodule Aoc2018.Day1 do
    
    def run_part1() do
        result = read_data()
        |> part1()

        IO.puts("The answer is #{result}")
    end

    def run_part2() do
        {freq, _} = read_data()
        |> part2()

        IO.puts("The answer is #{freq}")
    end

    def part1(data) do
        data |> Enum.sum
    end

    
    defp num("") do 0 end

    defp num(numStr) do
        String.to_integer(numStr)
    end

    def part2(data) do
        data 
        |> Stream.cycle()
        |> Enum.reduce_while({0, MapSet.new()}, fn e, acc -> f(e, acc) end)

    end

    defp f(change, {freq, history}) do
        new_freq = freq + change
        is_member = MapSet.member?(history, new_freq)
        update_history(is_member, freq + change, history)
    end

    defp update_history(true, freq, h) do
        {:halt, {freq, h}}
    end

    defp update_history(false, freq, history) do
        {:cont, {freq, MapSet.put(history, freq)}}
    end


    defp read_data() do
        "../../assets/Aoc2018/day1.txt"
        |> Path.expand(__DIR__)
        |> File.read!()
        |> String.trim()
        |> String.split("\n")
        |> Enum.map(fn x -> num(x) end)
    end
end