defmodule WordTiles.Game do
  def new do
    %{
        print: 1
    }
  end

 def client_view(game) do
    %{
        print: game.print
    }
  end

  def increase(game) do
      Map.put(game, :print, game.print+1)
  end
end