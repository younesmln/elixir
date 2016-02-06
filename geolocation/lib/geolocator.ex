defmodule Geolocator do
	@ip_list ["197.168.55.15"]

	def parallel(ip_list \\ @ip_list) do
		ip_list |> Enum.map(fn (ip) -> 
			Task.async(fn -> locate(ip) end)
		end)  |> Enum.map(&Task.await/1)
	end

	def sequential(ip_list \\ @ip_list) do
		Enum.map(ip_list, fn (ip) -> locate(ip) end)
	end
	def locate(ip) do
		case Geolix.lookup(ip) do
			%{country: country} ->
				location = get_in(country, [:country, :names, :en])
				IO.puts "IP: #{ip}  pays: #{location}"
			_ ->
				IO.puts "impossible de connaitre le pays de cette adresse IP #{ip}"
		end			
	end
end