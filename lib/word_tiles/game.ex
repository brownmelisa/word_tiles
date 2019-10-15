defmodule WordTiles.Game do

#  IO.puts("in the program")

  def new do
    %{
      board: make_board(),
      tile_bag: make_bag(),
      letters_left: 100,
      print: 1
    }
  end

  def client_view(game) do
    %{
        print: game.print
    }
  end

  def increase(game) do
    Map.put(game, :print, game.print+1)
  end

  # double_letter_positions = [2, 7, 37, 55, 102, 108, 117, 223]
  # double_word_positions = [11, 21, 41, 51, 81, 111, 171, 211]
  # triple_letter_positions = [5, 15, 45, 60, 80, 130, 142, 215]
  # triple_word_positions = [0, 30, 75, 90, 100, 150, 203, 224]

  # returns a new board list whose elements are updated
  def update(board, pos_list, val) do
    board
      # filter the board list for maps that match the double letter positions list
      |> Enum.filter( &(Enum.member?(pos_list, &1.position)) )
      # for each of the maps, change the value in bonus to "DL"
      |> Enum.map(fn x -> Map.put(x, :bonus, val) end)
  end

  # generates a starting board for a new game, board is 15 x 15 = 225
  def make_board() do
    IO.puts("IN MAKE BOARD\n\n")
    # create list of maps containing the keys: position, letter, and bonus
    dpos = [2, 3, 7]
    Enum.to_list(0..9)
      |> Enum.map(fn x ->  %{position: x, bonus: "", letter: ""} end)
      |> WordTiles.Game.update(dpos, "DL")
      |> IO.inspect()
  end

#    Enum.sort_by(points, fn(p) -> p.points end)


  # generates a bag of tiles for a new game
  def make_bag do
    [
      %{letter: "A", qty: 9, points: 1},
      %{letter: "B", qty: 2, points: 3},
      %{letter: "C", qty: 2, points: 3},
      %{letter: "D", qty: 4, points: 2},
      %{letter: "E", qty: 12, points: 1},
      %{letter: "F", qty: 2, points: 4},
      %{letter: "G", qty: 3, points: 2},
      %{letter: "H", qty: 2, points: 4},
      %{letter: "I", qty: 9, points: 1},
      %{letter: "J", qty: 1, points: 8},
      %{letter: "K", qty: 1, points: 5},
      %{letter: "L", qty: 4, points: 1},
      %{letter: "M", qty: 2, points: 3},
      %{letter: "N", qty: 6, points: 1},
      %{letter: "O", qty: 8, points: 1},
      %{letter: "P", qty: 2, points: 3},
      %{letter: "Q", qty: 1, points: 10},
      %{letter: "R", qty: 6, points: 1},
      %{letter: "S", qty: 4, points: 1},
      %{letter: "T", qty: 6, points: 1},
      %{letter: "U", qty: 4, points: 1},
      %{letter: "V", qty: 2, points: 4},
      %{letter: "W", qty: 2, points: 4},
      %{letter: "X", qty: 1, points: 8},
      %{letter: "Y", qty: 2, points: 4},
      %{letter: "Z", qty: 1, points: 10},
      %{letter: "_", qty: 2, points: 0},
    ]
  end

  # select a letter out of the tile bag, return the letter and update value
  def draw_tile (game) do
    case game.letters_left > 0 do
      true  ->
        letter_map =
          game.tile_bag
          |> Enum.filter(fn x -> x.qty > 0 end)
          |> Enum.random
        # TODO: update the qty and letters_left in bag
        letter_map.letter
      false -> game
    end
  end

  # TODO:
  # specify number of players in game
  # score calculation
  # rules for tile placement

end
