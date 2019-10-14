defmodule WordTiles.Dictionary do
  @doc """
  Reads a text file of 180,000 words in a dictionary and
  returns a list of words in the dictionary.
  file taken from: https://scrabutility.com/TWL06.txt
  """
  defp read_dictionary do
    "../../data/words_list.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn word -> word end)
  end



end
