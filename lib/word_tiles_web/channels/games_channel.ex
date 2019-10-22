defmodule WordTilesWeb.GamesChannel do
  use WordTilesWeb, :channel

  alias WordTiles.Game
  alias WordTiles.BackupAgent


  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      game = BackupAgent.get(name) || Game.new()
      BackupAgent.put(name, game)
      socket = socket
      |> assign(:game, game)
      |> assign(:name, name)
      {:ok, %{"join" => name, "game" => Game.client_view(game)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # def handle_in("increase", %{"num" => test}, socket) do
  #   name = socket.assigns[:name]
  #   game = Game.submit_word(socket.assigns[:game])
  #   socket = assign(socket, :game, game)
  #   BackupAgent.put(name, game)
  #   {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  # end
  

  def handle_in("increase", %{"num" => test}, socket) do
    name = socket.assigns[:name]
    game = Game.increase(socket.assigns[:game])
    socket = assign(socket, :game, game)
    BackupAgent.put(name, game)
    {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end


#  # HANDLE A NEW CHAT MESSAGE
#  def handle_in("new_chat_message", %{"body" => body}, socket) do
#    broadcast!(socket, "new_chat_message", %{
#      name: current_player(socket).name,
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
