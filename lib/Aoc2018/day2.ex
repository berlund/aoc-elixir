defmodule Aoc2018.Day2 do
    
    def part1() do
        {double, triple} = read_data()
        |> checksum_parts()

        IO.puts("The answer is #{double * triple}")
    end

    def checksum_parts(data) do
        Enum.reduce(data, {0,0}, fn code, sum -> sum_results(code, sum) end)
    end

    defp sum_results(code, acc) do
        count_dups_and_triplets(code)
        |> update_sum(acc)
    end

    defp update_sum({true, true}, {d, t}) do
        {d+1, t+1}
    end

    defp update_sum({false, false}, sum) do
        sum
    end

    defp update_sum({true, false}, {d, t}) do
        {d + 1, t}
    end

    defp update_sum({false, true}, {d, t}) do
        {d, t + 1}
    end

    def count_dups_and_triplets(str) do
        groups_bigger_than_one = group_by_same_character(str)
        |> Enum.filter(fn x -> x > 1 end)

        contains_duplicates = contains_number(groups_bigger_than_one, 2)
        contains_triplets = contains_number(groups_bigger_than_one, 3)

        {contains_duplicates, contains_triplets}
    end

    def group_by_same_character(code) do
        code
        |> to_sorted_enum()
        |> Enum.chunk_by(fn x -> x end)
        |> Enum.map(fn l -> Enum.count(l) end)
    end

    defp to_sorted_enum(str) do
        str
        |> String.codepoints
        |> Enum.sort()
    end

    defp contains_number(list, number) do
        Enum.any?(list, fn x -> x == number end)
    end

    defp read_data() do
        "../../assets/Aoc2018/day2.txt"
        |> Path.expand(__DIR__)
        |> File.read!()
        |> String.trim()
        |> String.split("\n")
    end
end