defmodule Aoc2018.Day2 do
    
    def part1() do
        {double, triple} = read_data()
        |> doubles_and_triples()

        IO.puts("The answer is #{double * triple}")
    end

    def part2() do
        id_list = read_data()

        result = read_data()
        |> Enum.reduce_while(id_list, &find_match/2)

        IO.puts("The answer is #{result}")
    end

    def find_match(id, list_of_ids) do
        Enum.reduce_while(list_of_ids, {:none, id}, &test_for_matching_pair/2)
        |> is_match(list_of_ids)
    end

    defp is_match({:none, _}, list_of_ids) do
        {:cont, list_of_ids}
    end

    defp is_match({:ok, id}, _) do
        {:halt, id}
    end

    defp test_for_matching_pair(id1, {_, id2}) do
        common = common_parts(id1, id2)
        length_diff = String.length(id1) - String.length(common)
        is_match(length_diff, id2, common)
    end


    defp is_match(1, _, common) do
        {:halt, {:ok, common}}
    end

    defp is_match(_, id2, _) do
        {:cont, {:none, id2}}
    end

    @doc """
    Returns a string that only contains the common characters in
    both provided strings, keeping their order
    """
    def common_parts(str_a, str_b) do
        a = String.codepoints(str_a)
        b = String.codepoints(str_b)

        Enum.zip(a, b)
        |> Enum.filter(fn {a,b} -> a==b end)
        |> Enum.flat_map(fn {a,a} -> [a] end)
        |> List.to_string()
    end


    def doubles_and_triples(data) do
        Enum.reduce(data, {0,0}, &aggregate_doubles_and_triples/2)
    end

    defp aggregate_doubles_and_triples(box_id, result) do
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
        groups = counts_of_same_chars(box_id)

        contains_duplicates = contains_number(groups, 2)
        contains_triplets = contains_number(groups, 3)

        {contains_duplicates, contains_triplets}
    end

    def counts_of_same_chars(code) do
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