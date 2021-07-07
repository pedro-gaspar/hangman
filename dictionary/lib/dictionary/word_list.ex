defmodule Dictionary.WordList do
  def random_word(words_list) do
    words_list
    |> Enum.random()
  end

  def start do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end
end
