require Logger

defmodule Cmd do
	def main(args) do
		Logger.info "#{args}"
		options = parser(args)
		Logger.info "#{options[:file]}"
		word_frequecy_map = File.stream!(options[:file]) |>

	end

	defp parser(args) do
		{options, _, _} = OptionParser.parse(args, switches: [file: :string])
		options
	end

	defp word_list_stream(file_stream) do
		map_func = fn (x) -> String.split(x, ~r{[^A-Za-z0-9_]}) end
		filter_func = fn (x) -> String.length() > 0 end
		file_stream |>
		Stream.flat_map(map_func) |>
		Stream.filter(filter_func)
	end
end

Cmd.main(System.argv())