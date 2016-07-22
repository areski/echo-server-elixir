defmodule Echo.Reverso do

  import String

  def reverso(message) do
    # this is a custom reverse method which trim \n and put it back at the end of the string
    # IO.puts(message)
    # let's trim to remove the "\n"
    reversed = message |> trim |> reverse
    reversed <> "\n"
  end

end