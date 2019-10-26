defmodule WordTilesWeb.GamesChannel do
  use WordTilesWeb, :channel

  alias WordTiles.Game
  alias WordTiles.BackupAgent
  alias WordTiles.GameServer

  def join("games:" <> game_name, payload, socket) do
    if authorized?(payload) do
       %{"person" => person_name} = payload

      GameServer.start(game_name)
      IO.puts("person name: " <> person_name)
      game = GameServer.peek(game_name)
      game = GameServer.add_player(game_name, person_name)

      # game = BackupAgent.get(game_name) || Game.new()
      
      BackupAgent.put(game_name, game)

      socket = socket
      |> assign(:game_name, game_name)
      |> assign(:person_name, person_name)
      {:ok, %{"join" => game_name, "game" => Game.client_view(game, person_name)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("increase", %{"text" => text}, socket) do
    game_name = socket.assigns[:game_name]
    person_name = socket.assigns[:person_name]
    text = person_name <> " says: " <> text
    IO.puts("increase channel")
    IO.puts(text)
    game = GameServer.increase(game_name, text)
    IO.inspect(game)
    broadcast!(socket, "update", %{ "game" => Game.client_view(game, person_name) })
    {:reply, {:ok, %{ "game" => Game.client_view(game, person_name)}}, socket}
  end

  def handle_in("chat_message", %{"msg" => msg}, socket) do

    game_name = socket.assigns[:game_name]
    person_name = socket.assigns[:person_name]
    msg = person_name <> " says: " <> msg
    game = GameServer.new_msg(game_name, msg)
    broadcast!(socket, "update", %{ "game" => Game.client_view(game, person_name) })
    {:reply, {:ok, %{ "game" => Game.client_view(game, person_name)}}, socket}
  end

  def handle_in("play_word", %{"letters" => letters, "position" => position}, socket) do
    game_name = socket.assigns[:game_name]
    person_name = socket.assigns[:person_name]
    IO.puts(person_name)
    IO.puts("letters")
    IO.inspect(letters)
    IO.inspect(position)
    game = GameServer.play_word(game_name, person_name, letters, position)

    broadcast!(socket, "update", %{ "game" => Game.client_view(game, person_name) })
    {:reply, {:ok, %{ "game" => Game.client_view(game, person_name)}}, socket}
  end

  # def handle_in("start_game", _, socket) do
  #   game_name = socket.assigns[:game_name]
  #   person_name = socket.assigns[:person_name]
  #   game = 
  # end


  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
