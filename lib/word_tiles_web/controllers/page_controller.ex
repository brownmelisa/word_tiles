defmodule WordTilesWeb.PageController do
  use WordTilesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def game(conn, %{"game_name" => game, "person_name" => person}) do
    IO.puts( "game_name:" <> game <> "\nperson_name:" <> person)
    render(conn, "game.html", %{name: game, person: person})
  end
end
