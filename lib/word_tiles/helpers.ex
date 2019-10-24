defmodule WordTiles.Helpers do

  # Generates random game names like "muddy-frog"
  def generate_game_name do
    [
      Enum.random(adjectives()),
      Enum.random(nouns()),
    ]
    |> Enum.join("-")
  end

  defp adjectives do
    ~w(
      angry bold happy muddy green
      spunky shy young black purple
      red noble hidden functional new
      ancient short frosty wispy fragrant
    )
  end

  defp nouns do
    ~w(
      sun moon meadow program warlock
      witch porcupine mountain smoke waterfall
      river breeze toad star dream
      dog bird tsunami pumpkin treat
    )
  end
end
