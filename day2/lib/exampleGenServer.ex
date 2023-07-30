# Tasks:
# 1. Fix the server to not crash on an empty state
# 2. Add methods to get the state length
# 2. Add the ability to snapshot the stack - save/restore
defmodule ExampleGenServer do
  require Logger
  use GenServer
  @me :stack_genserver

  def start_link(_a) do
    Logger.info("Hello")
    GenServer.start_link(__MODULE__, [], name: @me)
  end

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end

  def pop() do
    GenServer.call(@me, :pop)
  end
  def push(x) do
    GenServer.cast(@me, {:push, x})
  end
end
