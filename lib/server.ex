defmodule Echo.Server do

  @options [:binary, packet: :line, active: false, reuseaddr: true]

  def start(port) do
    {:ok, server} = :gen_tcp.listen(port, @options)
    loop_acceptor(server)
  end

  defp loop_acceptor(server) do
    {:ok, client} = :gen_tcp.accept(server)
    {:ok, pid} = Task.Supervisor.start_child(Echo.TaskSupervisor,
                                             fn -> read_message(client) end
                                             )
    :gen_tcp.controlling_process(client, pid)
    loop_acceptor(server)
  end

  defp read_message(client) do
    case :gen_tcp.recv(client, 0) do
      {:ok, "\r\n"} ->
        :gen_tcp.close(client)
      {:ok, message} ->
        message |> Echo.Worker.handle_message |> Echo.Reverso.reverso |> send_message(client)
        read_message(client)
      {:error, _} ->
        :gen_tcp.close(client)
    end
  end

  defp send_message(message, client) do
    :gen_tcp.send(client, message)
  end

end