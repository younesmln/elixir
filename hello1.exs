handle = fn 
	{0, 0, _} -> IO.puts "FizzBuzz"
	{0, _, _} -> IO.puts "Fizz" 
	{_, 0, _} -> IO.puts "Buzz"
	{_, _, c} -> IO.puts "#{c}"
end

func = fn
	(n) -> handle.({rem(n, 3), rem(n, 5), n}) 
end
############################################################
add_n = fn 
	(n) -> (fn other -> n+other end) 
end

add_two = add_n.(2)
add_five = add_n.(5)

IO.puts add_two.(3)
IO.puts add_five.(3)
##############################################################
greet = fn 
  name -> (fn -> "hello #{name}" end)
end
nd2 = greet.("younes")
IO.puts nd2.()
################################################################
prefix = fn 
  pre -> (fn name -> "#{pre} #{name}" end)  
end
mr = prefix.("Mr")
IO.puts mr.("younes")
IO.puts prefix.("my name is").("younes")
#############################################################
times_2 = fn n -> n*2 end
apply = fn (caller, val) -> caller.(val) end
IO.puts apply.(times_2,26)
############################################################
IO.inspect Enum.map [1, 2, 3, 4], &(&1+2)
IO.inspect Enum.map [1, 2, 3, 4], &(IO.inspect &1)
################################################################
defmodule Times do
	def double(n) do
		n*2
	end

	def quadruple(n) do
		double(n)*2
	end
end
#########################################################
defmodule Fact do
	def of(0), do: 0
	def of(n), do: n+of(n-1)

	def gc(x, 0), do: x
	def gc(x, y), do: gc(y, rem(x,y))

	def size([]), do: 0
	def size([x|rest]), do: 1+size(rest)
end
#########################################################
defmodule Util do
	def what_is(x) when is_number(x) do
		IO.puts "#{x} is a number"
	end

	def what_is(x) when is_list(x) do
		IO.puts "#{inspect(x)} is a list"
	end

	def what_is(x) when is_atom(x) do
		IO.puts "#{x} is an atom"
	end
end
###########################################################
defmodule Util do
	def guess(act, d..f) when div(d+f,2) == act do
		IO.puts "#{act}"
	end

	def guess(act, d..f) when div(d+f,2) > act and d<f do
		IO.puts "Is still < #{div(d+f,2)} between #{d} #{f}"
		guess(act, d..(div(d+f,2)-1))
	end

	def guess(act, d..f) when div(d+f,2) < act and d<f do
		IO.puts "Is still > #{div(d+f,2)} between #{d} #{f}"
		guess(act, (div(d+f,2)+1)..f)
	end

end
Util.guess(273, 1..1000)