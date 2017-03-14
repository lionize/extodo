defmodule TodoCacheTest do
  use ExUnit.Case, async: true

  alias Todo.Cache

  setup do
    {:ok, cache} = Cache.start_link()
    {:ok, %{cache: cache}}
  end

  test "server_process", %{cache: cache} do
    test_list = Cache.server_process(cache, "test_list")
    my_list = Cache.server_process(cache, "my_list")

    entry = %{date: {2013, 12, 20}, title: "Shopping"}
    Todo.Server.add_entry(test_list, entry)
    entry = Map.put(entry, :id, 1)
    found = Todo.Server.entries(test_list, entry.date) |> Enum.at(0)
    assert found == entry

    assert 0 == Todo.Server.entries(my_list, {2013, 12, 20}) |> Enum.count()
  end
end
