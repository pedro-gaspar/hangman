defmodule Dictionary do
  defdelegate start(), to: Dictionary.WordList
  defdelegate random_word(word_list), to: Dictionary.WordList
end
