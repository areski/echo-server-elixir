defmodule Echo.Worker do

  def handle_message(message) do
    {action, key, value} = parse_message(message)
    message =
      case action do
        :get ->
          # Echo.Storage.get(key)
          {:ok, value} = Redix.command(:redix, ~w(GET #{key}))
          message <> " -> Got #{key} with value: #{value}"
        :set ->
          # Echo.Storage.set(key, value)
          {:ok, _} = Redix.command(:redix, ~w(SET #{key} #{value}))
          message <> " -> SET #{key} #{value}"
        _ ->
          message <> " -> action not recognized..."
      end
    IO.puts message
    message <> "\n"
  end

  def parse_message(message) when is_bitstring(message) do
    # IO.puts "handle_message:"
    # IO.inspect message
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

end