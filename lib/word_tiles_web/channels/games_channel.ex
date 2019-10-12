defmodule WordTilesWeb.GamesChannel do
  use WordTilesWeb, :channel

  def join("games:lobby" <> name, payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (games:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # HANDLE A NEW CHAT MESSAGE
  def handle_in("new_chat_message", %{"body" => body}, socket) do
    broadcast!(socket, "new_chat_message", %{
      name: current_player(socket).name,
      body: body
    })
    {:noreply, socket}
  end

  defp current_player(socket) do
    socket.assigns.current_player
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
