defmodule Todo.Server do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end

  def server_processes(pid, name) do
    GenServer.call(pid, {:get_process, name})
  end

  def process_names(pid) do
    GenServer.call(pid, :process_names)
  end

  def init(_) do
    {:ok, Map.new}
  end

  def handle_call({:get_process, name}, _from, state) do
    case Map.get(state, name) do
      pid ->
        {:reply, pid, state}

      _ ->
        list = Todo.List.new
        new_state = Map.put(state, name, list)
        {:reply, list, new_state}
    end
  end

  def handle_call(:process_names, _from, state) do
    {:reply, Map.keys(state), state}
  end
end
