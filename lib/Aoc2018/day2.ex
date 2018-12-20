defmodule Aoc2018.Day2 do
    
    def part1() do
        {double, triple} = read_data()
        |> checksum_parts()

        IO.puts("The answer is #{double * triple}")
    end

    def part2() do
        id_list = read_data()

        read_data()
        |> Enum.reduce_while(id_list, fn box_id, list -> find_match(box_id, list) end)
    end

    def find_match(id, list_of_ids) do
        match_result = Enum.reduce_while(list_of_ids, {:none, id}, fn elem, acc -> test_for_matching_pair(elem, acc) end)
        # :ok -> :halt, id

        IO.inspect match_result
        is_match(match_result, list_of_ids)
    end

    defp is_match({:none, _}, list_of_ids) do
        {:cont, list_of_ids}
    end

    defp is_match({:ok, id}, _) do
        {:halt, id}
    end

    def test_for_matching_pair(id1, {_, id_to_test}) do
        common = common_parts(id1, id_to_test)
        length_diff = String.length(id1) - String.length(common)
        is_match(length_diff, id_to_test, common)
    end


    defp is_match(1, id2, common) do
        {:halt, {:ok, common}}
    end

    defp is_match(_, id2, _) do
        {:cont, {:none, id2}}
    end

    def common_parts(str_a, str_b) do
        a = String.codepoints(str_a)
        b = String.codepoints(str_b)

        Enum.zip(a, b)
        |> Enum.filter(fn {a,b} -> a==b end)
        |> Enum.flat_map(fn {a,a} -> [a] end)
        |> List.to_string()
    end


    def checksum_parts(data) do
        Enum.reduce(data, {0,0}, fn box_id, result -> sum_results(box_id, result) end)
    end

    defp sum_results(box_id, result) do
        count_dups_and_triplets(box_id)
        |> update_sum(result)
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

    def count_dups_and_triplets(box_id) do
        groups_bigger_than_one = group_by_same_character(box_id)
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