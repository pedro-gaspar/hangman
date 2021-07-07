defmodule TextClient.Interact do
  alias TextClient.{Player, State}

  def start() do
    xpto = 4

    IO.puts(xpto)

    Hangman.new_game()
    |> setup_state()
    |> Player.play()
  end

  defp setup_state(game) do
    %State{
      game_service: game,
      tally: Hangman.tally(game)
    }
  end
end
