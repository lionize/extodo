defmodule Todo.List do
  defstruct autoid: nil, entries: nil

  def new, do: %Todo.List{autoid: 1, entries: Map.new()}

  def entries(%Todo.List{entries: entries}, date) do
    entries
    |> Map.keys()
    |> Enum.reduce([], fn (id, acc) ->
      if entries[id].date == date do
        [id|acc]
      else
        acc
      end
    end)
    |> Enum.map(fn id ->
      entries[id]
    end)
  end

  def add_entry(%Todo.List{autoid: id, entries: entries} = list, entry) do
    entry = Map.put(entry, :id, id)
    new_entries = Map.put(entries, id, entry)
    %{list | autoid: id + 1, entries: new_entries}
  end

  def update_entry(%Todo.List{entries: entries} = list, id, func) do
    case entries[id] do
      nil -> list

      old_entry ->
        new_entry = func.(old_entry)
        new_entries = Map.put(entries, new_entry.id, new_entry)
        %Todo.List{list | entries: new_entries}
    end
  end

  def delete_entry(%Todo.List{entries: entries} = list, id) do
    new_entries = Map.delete(entries, id)
    %Todo.List{list | entries: new_entries}
  end

  def size(list) do
    Map.keys(list.entries)
    |> Enum.count()
  end
end
