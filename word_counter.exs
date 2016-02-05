require Logger

defmodule Cmd do
	def main(args) do
		Logger.info "#{args}"
		options = parser(args)
		Logger.info "#{options[:file]}"
		word_frequecy_map = File.stream!(options[:file]) |>
							word_list_stream |>
							count_words
		file_write(word_frequecy_map)
		Logger.info "finished ...."					
	end

	defp parser(args) do
		{options, _, _} = OptionParser.parse(args, switches: [file: :string])
		options
	end

	defp word_list_stream(file_stream) do
		map_func = fn (x) -> String.split(x, ~r{[^A-Za-z0-9_]}) end
		filter_func = fn (x) -> String.length(x) > 0 end
		file_stream |>
		Stream.flat_map(map_func) |>
		Stream.filter(filter_func)
	end

	defp count_words(stream) do
		count_words(Enum.to_list(stream), Map.new)
	end
	defp count_words([], map), do: map
	defp count_words([word| rest], map) do
		case Map.has_key?(map, word)do
			true ->
				map1 = Map.update!(map, word, &(&1+1))
				count_words(rest, map1)
			false ->
				map1 = Map.put_new(map, word, 1)
				count_words(rest, map1)	
		end
	end

	defp file_write(map) do
		reduce_func = fn (key, acc) ->
			acc <> "#{key} : #{Map.get(map, key)} time(s)\n"
		end 
		output = map |> Map.keys |> Enum.reduce("", reduce_func)
		File.write!("word_frequecy.txt", output)
	end
end

Cmd.main(System.argv())