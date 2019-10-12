defmodule WordTilesWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  # channel "room:*", WordTilesWeb.RoomChannel
  channel "games:*", WordTilesWeb.GamesChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  # Verify the token which should return the player, and then
  # assign that player to the socket. This allows us to reference
  # the player in the callback functions of the channel module.
  #
  # max_age: 86400 is equivalent to one day in seconds
  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "player auth", token, max_age: 86400) do
      {:ok, player} ->
        {:ok, assign(socket, :current_player, player)}
      {:error, _reason} ->
        :error
    end
  end


  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     WordTilesWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
