# Distributed systems workshops 

# Day 1 - Elixir basics
## New project
```bash
mix new day1 --module Workshops # Create a new elixir project
cd day1
iex -S mix # Start project in an interactive shell
```
## The basics
```elixir
# Numbers
1 + 2
1
2 * 2
# Floats
1 + 2.0
# Lists(https://hexdocs.pm/elixir/1.12.3/List.html)
[1, 2, 3, 4]
[1, "two", 3]
[1 | [2, 3, 4]]
[1 | 2] # improper list
# Inspect type of something
i [1, 2]
# Pattern matching
[head | tail] = [1, 2, 3]
1 = 1
1 = 2
# Character lists
'asdf'
# Strings
"ASDF"
"A" <> t = "ASDF"
# Atoms
:asdf
# Tuples
{ 1, 2 }
# "Booleans"
true
false
1 == 1
true == :true
false == :false
# Almost everything is an atom
(List.last [1,2,3]) == 3
List == :"Elixir.List"
Hmm == :"Elixir.Hmm"
# Anonymous Functions
add = fn (a, b) -> a + b end
add.(1, 2)
mul = &(&1 * &2)
mul.(2, 3)
# Printing stuff
IO.puts "ASDF"
# Help
h IO.puts/1
h IO.puts/2
# Writing functions on lists + pattern matching
# - List length
# - List reverse
# - List map
# - Fibonacci
# Function composition using the |> operator + builtins
# Data structures? - T = {:leaf, V} | {:node, T}
```

# Day 2 - Let's write map reduce
## Odpalenie projektu
```bash
cd day2
mix deps.get
iex --cookie mycookie --name node1@127.0.0.1 -S mix run
```

## Warmup
- Write a function which applies an anonymous function to every element of a list
- Write fold left & reduce

## Processes
```elixir
# Message passing
self # what is this?
spawn fn -> :asdf end # what is this?
pid = spawn(fn -> 1 + 2 end)
Process.alive?(pid)
Process.alive?(self())
send(self, :hello)
receive do x -> IO.puts x end
:nothing == (receive do x -> x after 1_000 -> :nothing end)
send(self, :hello)
:hello == (receive do x -> x after 1_000 -> :nothing end)
# Supervision tree - spawn_link
# Genserver
```

## Playing with gen server with stack

## Implementing naive map reduce
Prezentacja: http://soft.vub.ac.be/~tvcutsem/talks/presentations/tvcutsem_MapReduce_ErlangFactory.pdf
https://gist.github.com/oxling/3194570

## RPC between nodes - Distributed Erlang!

# Day3 - let's write a p2p Discord
## Project setup
```bash
mix phx.new day3 --no-ecto
cd day3
HEX_MIRROR=https://cdn.jsdelivr.net/hex mix deps.get
iex -S mix phx.server
```

## Run distributed phoenix
```
iex --cookie asdf --name mike@(tailscale ip -4) -S mix phx.server
```
