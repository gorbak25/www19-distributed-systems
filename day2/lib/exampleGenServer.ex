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
    {:ok, {{stack, 0}, []}}
  end

  @impl true
  def handle_call(:pop, _from, {{[head | tail], l}, s}) do
    {:reply, {:ok, head}, {{tail, l-1}, s}}
  end
  def handle_call(:pop, _from, {{[], 0}, _} = state) do
    {:reply, {:err, "stack empty"}, state}
  end
  def handle_call(:len, _from, {{_, l}, _} = state) do
    {:reply, l, state}
  end
  def handle_call(:restore, _from, {_, [s1 | sr]}) do
    {:reply, :ok, {s1, sr}}
  end
  def handle_call(:restore, _from, {_, []} = state) do
    {:reply, {:err, "no snapshots"}, state}
  end

  @impl true
  def handle_cast({:push, element}, {{state, l}, s}) do
    {:noreply, {{[element | state], l+1}, s}}
  end
  def handle_cast(:snapshot, {s1, sr}) do
    {:noreply, {s1, [s1 | sr]}}
  end

  def pop() do
    GenServer.call(@me, :pop)
  end
  def push(x) do
    GenServer.cast(@me, {:push, x})
  end
  def len() do
    GenServer.call(@me, :len)
  end

  def snapshot() do
    GenServer.cast(@me, :snapshot)
  end
  def restore() do
    GenServer.call(@me, :restore)
  end
end
