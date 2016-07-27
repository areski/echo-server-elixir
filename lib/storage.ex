#
# This is not used anymore we use the global redix
# https://hexdocs.pm/redix/real-world-usage.html
#

defmodule Echo.Storage do
  use GenServer

  @redis_host "localhost"
  @redis_port 6379

  # External API

  def start_link(name) do
    IO.puts "Echo.Storage start_link..."
    IO.puts name
    GenServer.start_link(__MODULE__, name, name: name)
  end

  def set(key, value) do
    GenServer.cast(__MODULE__, {:set, key, value})
  end

  # def set_sync(key, value) do
  #   GenServer.call(__MODULE__, {:set, key, value})
  # end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  # GenServer implementation

  def init(table) do
    IO.puts table
    # {:ok, conn} = Redix.start_link(@redis_host, @redis_port)
    {:ok, conn} = Redix.start_link()
    IO.puts "Echo.Storage init..."
    # conn becomes state available in handle_call / hand_cast
    {:ok, conn}
  end

  # Server (callbacks)

  # Async
  def handle_cast({:set, key, value}, conn) do
    {:ok, _} = Redix.command(conn, ~w(SET #{key} #{value}))
    IO.puts "set_redis:> #{key}-#{value}"
    {:noreply, conn}
  end

  # Sync
  # def handle_call({:set, key, value}, conn) do
  #   {:ok, _} = Redix.command(conn, ~w(SET #{key} #{value}))
  #   IO.puts "set_redis:> #{key}-#{value}"
  #   {:reply, :ok, conn}
  # end

  def handle_call({:get, key}, conn) do
    {:ok, value} = Redix.command(conn, ~w(GET #{key}))
    IO.puts "get_redis:> #{value}"
    {:reply, :ok, conn}
  end

end