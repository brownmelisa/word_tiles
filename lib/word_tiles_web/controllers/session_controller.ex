defmodule WordTilesWeb.SessionController do
  # The SessionController makes sure the player's name is stored
  # in the session before playing the game
  use WordTilesWeb, :controller


  def new(conn, _params) do
    render(conn, "index.html")
  end

  # def create(conn, %{"player" => %{"name" => name}}) do
  #   player = WordTiles.Game.make_player(name)

  #   conn
  #   |> put_session(:current_player, player)
  #   |> join_game_or_create_new
  # end

  # def delete(conn, _) do
  #   conn
  #   |> delete_session(:current_player)
  #   |> redirect(to: "/")
  # end

  # this function is used when a player gets a url to join game
  # defp join_game_or_create_new(conn) do
  #   path = get_session(conn, :return_to)
#    || game_path(conn, :new)

#     conn
#     |> put_session(:return_to, nil)
#     |> redirect(to: path)
#   end
 end
