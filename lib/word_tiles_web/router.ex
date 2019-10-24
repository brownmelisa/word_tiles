defmodule WordTilesWeb.Router do
  use WordTilesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WordTilesWeb do
    pipe_through :browser

    # this route runs the :index action of PageController
    # which brings you to index.html
    get "/", PageController, :index

    # renders game.html for the game name
    post "/game", PageController, :game


#    # creates game name and renders game.html for the game
#    resources "/game", PageController, only: [:index, :create, :show]
#
#    resources "/sessions", SessionController,
#              only: [:new, :create, :delete], singleton: true
  end

  # Other scopes may use custom stacks.
  # scope "/api", WordTilesWeb do
  #   pipe_through :api
  # end
end
