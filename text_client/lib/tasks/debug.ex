defmodule Mix.Tasks.Debug do
  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    IO.puts("debugging...")
    TextClient.start()
  end
end
