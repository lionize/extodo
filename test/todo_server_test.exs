defmodule TodoServerTest do
  use ExUnit.Case, async: true
  alias Todo.Server

  test "stores and retrieves entries" do
    {:ok, pid} = Server.start_link

    entry = %{date: {2013, 12, 20}, title: "Shopping"}

    Server.add_entry(pid, entry)

    entry = Map.put(entry, :id, 1)
    found = Server.entries(pid, entry.date) |> Enum.at(0)

    assert found.date == entry.date
  end
end
