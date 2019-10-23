defmodule WordTilesWeb.PageController do
  use WordTilesWeb, :controller

#  plug :require_player

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def game(conn, %{"name" => name}) do
    render conn, "game.html", name: name
  end

#  def create(conn, _params) do
#    game_name = WordTiles.Helpers.generate_game_name()
#
#    case GameSupervisor.start_child(game_name) do
#      {:ok, _game_pid} ->
#        redirect(conn, to: game_path(conn, :show, game_name))
#
#      {:error, _error} ->
#        conn
#        |> put_flash(:error, "Unable to start game!")
#        |> redirect(to: game_path(conn, :new))
#    end
#  end
#
#  def show(conn, %{"id" => game_name}) do
#    case GameServer.game_pid(game_name) do
#      pid when is_pid(pid) ->
#        conn
#        |> assign(:game_name, game_name)
##        |> assign(:auth_token, generate_auth_token(conn))
#        |> render("game.html")
#
#      nil ->
#        conn
#        |> put_flash(:error, "Game not found!")
#        |> redirect(to: game_path(conn, :new))
#    end
#  end
#
#  defp require_player(conn, _opts) do
#    if get_session(conn, :current_player) do
#      conn
#    else
#      conn
#      |> put_session(:return_to, conn.request_path)
#      |> redirect(to: session_path(conn, :new))
#      |> halt()
#    end
#  end

end
