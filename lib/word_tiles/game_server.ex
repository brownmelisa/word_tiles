defmodule WordTiles.GameServer do
  @moduledoc """
  A game server process that holds a game defined in game.ex as its state.
  """

  use GenServer

  @doc """
  Returns a tuple used to register and lookup a game server process by name.
  - :via tag
  - tuple of 1. WordTiles.GameReg is the name of our registry process (not actually a file),
             2. the name we want to associate with the pid.

  """
  def reg(name) do
    {:via, Registry, {WordTiles.GameReg, name}}
  end

  def start(name) do
    spec = %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [name]},
      restart: :permanent,
      type: :worker,
    }
    WordTiles.GameSup.start_child(spec)
  end

  @doc """
  Spawns a new game server process registered under the given "name"
  or gets the game server process by the name provided
  """
  def start_link(name) do
    game = WordTiles.BackupAgent.get(name) || WordTiles.Game.new()
    GenServer.start_link(__MODULE__, game, name: reg(name))
  end

  def guess(name, letter) do
    GenServer.call(reg(name), {:guess, name, letter})
  end

  def peek(name) do
    GenServer.call(reg(name), {:peek, name})
  end

  def draw_tile(name, player) do
    GenServer.call(reg(name), {:draw_tile, name, player})
  end

  # init is triggered by the start_link function.
  # returns the state of the game
  def init(game) do
    {:ok, game}
  end


  def handle_call({:guess, name, letter}, _from, game) do
    game = WordTiles.Game.guess(game, letter)
    WordTiles.BackupAgent.put(name, game)
    {:reply, game, game}
  end

  def handle_call({:peek, _name}, _from, game) do
    {:reply, game, game}
  end

  def handle_call({:draw_tile, name, player}, _from, game) do
    game = WordTiles.Game.draw_tile(game, player)
    WordTiles.BackupAgent.put(name, game)
    {:reply, game, game}
  end



end
