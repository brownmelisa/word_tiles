defmodule WordTiles.GameSup do
  # A supervisor that starts `GameServer` processes dynamically.

  use DynamicSupervisor

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    {:ok, _} = Registry.start_link(keys: :unique, name: WordTiles.GameReg)
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  # Starts a `GameServer` process and supervises it.
  def start_child(spec) do
    DynamicSupervisor.start_child(__MODULE__, spec)
  end
end
