defmodule WordTilesWeb.PageController do
  use WordTilesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
