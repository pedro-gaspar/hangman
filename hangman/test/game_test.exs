defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "game letters are lowercase" do
    game = Game.new_game()

    for _ <- 0..5 do
      assert Enum.all?(game.letters, &(&1 == String.downcase(&1)))
    end
  end

  test "state isn't changed for :won ir :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert {^game, _} = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    {game, _} = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    game = Game.new_game()
    {game, _} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    {game, _} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"l", :good_guess},
      {"e", :won}
    ]

    new_game = Game.new_game("wibble")

    moves
    |> Enum.reduce(new_game, fn {guess, state}, game ->
      {game, _} = Game.make_move(game, guess)
      assert game.game_state == state
      assert game.turns_left == 7
      game
    end)
  end

  test "a bad guess is recognized" do
    game = Game.new_game("wibble")
    {game, _} = Game.make_move(game, "x")

    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "lost game is recognized" do
    moves = [
      {"x", :bad_guess, 6},
      {"y", :bad_guess, 5},
      {"z", :bad_guess, 4},
      {"u", :bad_guess, 3},
      {"r", :bad_guess, 2},
      {"s", :bad_guess, 1},
      {"t", :lost, 0}
    ]

    new_game = Game.new_game("wibble")

    moves
    |> Enum.reduce(new_game, fn {guess, state, turns_left}, game ->
      {game, _} = Game.make_move(game, guess)
      assert game.game_state == state

      if state != :lost, do: assert(game.turns_left == turns_left)
      game
    end)
  end
end
