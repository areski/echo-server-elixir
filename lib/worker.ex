defmodule Echo.Worker do

  def handle_message(message) do
    {action, key, value} = parse_message(message)
    case action do
      :get ->
        get_redis(key)
      :set ->
        set_redis(key, value)
      _ ->
        IO.puts "action not recognized..."
    end
    message
  end

  def parse_message(message) when is_bitstring(message) do
    IO.puts "handle_message:"
    IO.inspect message
    case String.split(message) do
      ["SET", key, value] ->
        {:set, key, value}
      ["GET", key] ->
        {:get, key, nil}
      _ ->
        {:unknow, nil, nil}
    end
  end

  def parse_message(message) when is_list(message) do
    # closing connection
    {:unknow, nil, nil}
  end

  defp set_redis(key, value) do
    {:ok, conn} = Redix.start_link()
    # Set key value
    {:ok, _} = Redix.command(conn, ~w(SET #{key} #{value}))
    IO.puts "set_redis:> #{key}-#{value}"
  end

  defp get_redis(key) do
    {:ok, conn} = Redix.start_link()
    # Get key value
    {:ok, value} = Redix.command(conn, ~w(GET #{key}))
    IO.puts "get_redis:> #{value}"
  end

end