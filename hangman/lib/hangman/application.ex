defmodule Hangman.Application do
  use Application

  def start(_type, _args) do
    DynamicSupervisor.start_link(__MODULE__, [], name: Hangman.Supervisor)
  end

  def init(_init_arg) do
    DynamicSupervisor.init(
      strategy: :one_for_one,
      extra_arguments: []
    )
  end
end
