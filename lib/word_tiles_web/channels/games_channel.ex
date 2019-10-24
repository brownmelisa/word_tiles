defmodule WordTilesWeb.GamesChannel do
  use WordTilesWeb, :channel

  alias WordTiles.Game
  alias WordTiles.BackupAgent
  alias WordTiles.GameServer


  # def join("games:" <> game_name, payload, socket) do
  #   if authorized?(payload) do
  #      %{"person" => person_name} = payload

  #     IO.puts("person name: " <> person_name)
  #     game = BackupAgent.get(game_name) || Game.new()
  #     BackupAgent.put(game_name, game)
  #     socket = socket
  #     |> assign(:game, game)
  #     |> assign(:game_name, game_name)
  #     {:ok, %{"join" => game_name, "game" => Game.client_view(game)}, socket}
  #   else
  #     {:error, %{reason: "unauthorized"}}
  #   end
  # end

  def join("games:" <> game_name, payload, socket) do
    if authorized?(payload) do
       %{"person" => person_name} = payload

      GameServer.start(game_name)
      IO.puts("person name: " <> person_name)
      game = GameServer.peek(game_name)

      game = BackupAgent.get(game_name) || Game.new()
      BackupAgent.put(game_name, game)
      socket = socket
      |> assign(:game_name, game_name)
      |> assign(:person_name, person_name)
      {:ok, %{"join" => game_name, "game" => Game.client_view(game)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end


  def handle_in("increase", %{"num" => test}, socket) do
    game_name = socket.assigns[:game_name]
    game = GameServer.increase(game_name)
    broadcast!(socket, "update", %{ "game" => Game.client_view(game) })
    {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

#  # HANDLE A NEW CHAT MESSAGE
#  def handle_in("new_chat_message", %{"body" => body}, socket) do
#    broadcast!(socket, "new_chat_message", %{
#      game_name: current_player(socket).game_name,
#      body: body
#    })
#    {:noreply, socket}
#  end
#
#  defp current_player(socket) do
#    socket.assigns.current_player
#  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
