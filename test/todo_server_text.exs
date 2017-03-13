defmodule TodoServerTest do
  use ExUnit.Case, async: true
  alias Todo.Server

  setup do
    {:ok, pid} = Server.start_link()
    list_pid = Server.server_processes(pid, "test_list")
    Todo.List.add_entry(list_pid, %{date: {2013, 12, 19}, title: "Shopping"})
    {:ok, %{server: pid}}
  end

  test "server_processes", %{server: pid} do
    test_list = Server.server_processes(pid, "test_list")
    assert(1 == Todo.List.size(test_list))

    my_list = Server.server_processes(pid, "my_list")
    assert(0 == Todo.List.size(my_list))
    Todo.List.add_entry(my_list, %{date: {2013, 12, 20}, title: "Movies"})
    assert(1 == Todo.List.size(my_list))
  end

  test "process_names", %{server: pid} do
    assert(["test_list"] == Server.process_names(pid))

    Server.server_processes(pid, "my_list")
    assert(["test_list", "my_list"] == Server.process_names(pid))
  end
end
