defmodule WordTiles.Game do

#  IO.puts("in the program")

  def new do
    %{
      board: make_board(),
      bag: make_bag(),
      letters_left: 100,
      players: [],
      print: 1
    }
  end

  def client_view(game) do
    %{
      board: game.board,
      letters_left: game.letters_left,
      player_tiles: [],
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
#  def update(board, pos_list, val) do
#    new_list = board
#      # filter the board list for maps that match the double letter positions list
#      |> Enum.filter( &(Enum.member?(pos_list, &1.position)) )
#      # for each of the maps, change the value in bonus to "DL"
#      |> Enum.map(fn x -> Map.put(x, :bonus, val) end)
#    new_list
#  end

  # generates a starting board for a new game, board is 15 x 15 = 225
  def make_board() do
    double_letter = [2, 3, 7]
    # create list of maps containing the keys: position, letter, and bonus
    board = Enum.to_list(0..224)
      # create a list of maps with positions filled in with 0-224
      |> Enum.map(fn x ->  %{position: x, bonus: "", letter: ""} end)
#      |> update(double_letter, "DL")
#      |> IO.inspect()
    board = List.replace_at(board, 112, %{position: 112, bonus: "X", letter: ""})
    board = List.replace_at(board, 2, %{position: 2, bonus: "DL", letter: ""})
    board = List.replace_at(board, 102, %{position: 102, bonus: "DL", letter: ""})
    board = List.replace_at(board, 41, %{position: 41, bonus: "DW", letter: ""})
    board = List.replace_at(board, 111, %{position: 111, bonus: "DW", letter: ""})
    board = List.replace_at(board, 15, %{position: 15, bonus: "TL", letter: ""})
    board = List.replace_at(board, 130, %{position: 130, bonus: "TL", letter: ""})
    board = List.replace_at(board, 75, %{position: 75, bonus: "TW", letter: ""})
    board = List.replace_at(board, 203, %{position: 203, bonus: "TW", letter: ""})
  end


#    case game.letters_left > 0 do
#      true  ->
#        letter_map =
#          game.bag
#          |> Enum.filter(fn x -> x.qty > 0 end)
#          |> Enum.random
#
#        # TODO: update the qty and letters_left in bag
#        Map.put(game, :letters_left, game.letters_left - 1)
#        letter_map.letter
#      false -> game


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


#    gs = game.guesses
#         |> MapSet.new()
#         |> MapSet.put(letter)
#         |> MapSet.to_list
#
#    Map.put(game, :guesses, gs)

end

  # TODO:
  # draw tiles
  # specify number of players in game
  # score calculation
  # rules for tile placement
  # keep track of letters that each player has
  # user submits word
  # verify word in dictionary
  # calculate points

