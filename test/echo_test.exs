defmodule EchoTest do
  use ExUnit.Case
  doctest Echo

  # test "the truth" do
  #   assert 1 + 1 == 2
  # end

  setup do
    {:ok, socket} = :gen_tcp.connect('localhost', 12321, [:binary, packet: :line, active: false])
    {:ok, [socket: socket]}
  end

  test "hearing an Echo", %{socket: socket} do
    :ok = :gen_tcp.send(socket, "Hello, world!\n")

    case :gen_tcp.recv(socket, 0) do
      {:ok, response} ->
        # assert response == "Hello, world!\n"
        assert response == "!dlrow ,olleH\n"
      {:error, reason} ->
        flunk "Did notreceiveresponse: #{reason}"
    end
  end

  test "sending a carriage return terminates the request", %{socket: socket} do
    :ok = :gen_tcp.send(socket, "Hello, world!\n")
    :ok = :gen_tcp.send(socket, "Hello, world!\n")
    :ok = :gen_tcp.send(socket, "\r\n")

    :gen_tcp.recv(socket, 0) # Returns the first Hello, world!
    :gen_tcp.recv(socket, 0) # Returns the second Hello, world!


    case :gen_tcp.recv(socket, 0) do # Socket should be closed
      # {:ok, response} ->
      #   assert response == "\r\n"
      {:error, response} ->
        assert response == :closed
    end
  end
end
