defmodule Todo.Server do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end

  def entries(pid, date) do
    GenServer.call(pid, {:entries, date})
  end

  def add_entry(pid, entry) do
    GenServer.cast(pid, {:add_entry, entry})
  end

  def init(_) do
    {:ok, Todo.List.new}
  end

  def handle_call({:entries, date}, _, list) do
    {:reply, Todo.List.entries(list, date), list}
  end

  def handle_cast({:add_entry, entry}, list) do
    {:noreply, Todo.List.add_entry(list, entry)}
  end
end
