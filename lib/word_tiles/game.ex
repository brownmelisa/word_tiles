defmodule WordTiles.Game do

#  IO.puts("in the program")

  def new do
    %{
      board: make_board(),
      bag: make_bag(),
      letters_left: 100,
      players: [],  # [%{id: 1, name: "smokey", letters: ["A", "B"], score: 0}],
      print: 1,
      dictionary: read_dictionary(),
      winner: nil
    }
  end

  def client_view(game) do
    %{
      board: game.board,
      letters_left: game.letters_left,
      # This is mock input, change after implementation.
      player_tiles: ["A","B", "C", "D","E", "F"],
      print: game.print
    }
  end

  @doc """
  Reads a text file of 180,000 words in a dictionary and
  returns a list of words in the dictionary.
  file taken from: https://scrabutility.com/TWL06.txt
  """
  def read_dictionary do
    "../../data/words_list.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> (x |> String.replace("\r", "")) end)
  end

  # uses to play and pass
  # if pass, the last two fields will be blank
  def submit_word(game, player, letters, positions) do
    if length(letters) < 1 do
      game
    else
      game
      |> update_board(game, letters, positions)
      |> update_player_score(game, player, letters, positions)
      |> draw_n_tiles(game, player)
    end

  end


  def update_board(game, letters, positions) do

  end

  def get_word(game, letters, positions) do
    # check if the letter are placed horizontally or vertically
    if length(letters) == 1 do

    end

    # get the word on the same axis that letters are placed

    # get any peripheral words
  end



  # verify word in dictionary, returns true or false
  def is_in_dict(game, word) do
    Enum.member?(game.dictionary, word)
  end


  # calculates the score of a given a list of letters
  # and their corresponding positions
  def calculate_score(game, letters, positions) do


  end



  def make_player(name) do
    %{name: name, letters: [], score: 0}
  end

  def add_player(game, name) do
    case List.last(game.players) == nil do
      true ->
        player = make_player(name)
        Map.put(game, :players, [player])
      false ->
        player = make_player(name)
        new_players =
          game.players
          |> Enum.concat( [player] )
        IO.inspect(new_players)
        Map.put(game, :players, new_players)
    end
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
#    double_letter = [2, 3, 7]
    # create list of maps containing the keys: position, letter, and bonus
    board = Enum.to_list(0..224)
      # create a list of maps with positions filled in with 0-224
      |> Enum.map(fn x ->  %{position: x, bonus: "", letter: ""} end)
#      |> update(double_letter, "DL")
#      |> IO.inspect()
#    board = List.replace_at(board, 112, %{position: 112, bonus: "X", letter: ""})
    board = List.replace_at(board, 2, %{position: 2, bonus: "DL", letter: ""})
    board = List.replace_at(board, 102, %{position: 102, bonus: "DL", letter: ""})
    board = List.replace_at(board, 41, %{position: 41, bonus: "DW", letter: ""})
    board = List.replace_at(board, 111, %{position: 111, bonus: "DW", letter: ""})
    board = List.replace_at(board, 15, %{position: 15, bonus: "TL", letter: ""})
    board = List.replace_at(board, 130, %{position: 130, bonus: "TL", letter: ""})
    board = List.replace_at(board, 75, %{position: 75, bonus: "TW", letter: ""})
    List.replace_at(board, 203, %{position: 203, bonus: "TW", letter: ""})
  end

#  def draw_n_tiles(game, letters_left, player_name, n) when n==1 do
#    game |> draw_tile(game.letters_left, player_name)
#  end
#
#  def draw_n_tiles(game, letters_left, player_name, n) do
#    new_game = draw_n_tiles(game, game.letters_left, player_name, n-1)
#    draw_n_tiles(new_game, game.letters_left, player_name, n-1)
#  end

  def draw_tile(game, player_name) do
    if game.letters_left > 0 do
      draw_tile(game, player_name, game.letters_left)
    end
  end

  def draw_tile(game, player_name, _letters_left) do
    letter_map = game.bag |> Enum.filter(fn x -> x.qty > 0 end) |> Enum.random
    game
    |> pick_from_bag(letter_map)
    |> add_to_player_letters(player_name, letter_map.letter)
    |> decrement_letters_left
  end

  # select a letter out of the tile bag, return the letter and update value
  def pick_from_bag(game, letter_map) do
    new_bag =
      game.bag |> Enum.map(&decrement_count_of_letter(&1, letter_map.letter))
    Map.put(game, :bag, new_bag)   #or %{game | bag: new_bag}
  end

  # checks if a letter map has the letter and decrements the count if matches
  def decrement_count_of_letter(letter_map, letter) do
    case letter_map.letter == letter do
      true -> %{letter_map | qty: letter_map.qty - 1}
      false -> letter_map
    end
  end

  def add_to_player_letters(game, player_name, letter) do
    new_players =
      game.players
      |> Enum.map(&find_player_update_letter(&1, player_name, letter))
    Map.put(game, :players, new_players)
  end

  def find_player_update_letter(player_map, player_name, letter) do
    case player_map.name == player_name do
      true -> %{player_map | letters: Enum.concat(player_map.letters, [letter]) }
      false -> player_map
    end
  end

  def decrement_letters_left(game) do
    Map.put(game, :letters_left, game.letters_left - 1)
  end

  # generates a bag of tiles for a new game

  def make_bag do
    [
      %{letter: "A", qty: 10, points: 1},
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
      %{letter: "Q", qty: 2, points: 10},
      %{letter: "R", qty: 6, points: 1},
      %{letter: "S", qty: 4, points: 1},
      %{letter: "T", qty: 6, points: 1},
      %{letter: "U", qty: 4, points: 1},
      %{letter: "V", qty: 2, points: 4},
      %{letter: "W", qty: 2, points: 4},
      %{letter: "X", qty: 1, points: 8},
      %{letter: "Y", qty: 2, points: 4},
      %{letter: "Z", qty: 1, points: 10},
    ]
  end


end

  # TODO:
  # rules for tile placement
  # user submits word
  # display tiles for each user
  # change state of board if user enters an entry on board

  # work on play, no pass, no swap button

  # to ask
  # how to pass player-specific tiles to the front end
  # call draw tiles multiple times
