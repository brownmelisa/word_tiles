defmodule WordTiles.Game do
  @doc """
  External-facing functions.
  All return a full game state except for client_view() which returns a partial
  game state for individual players.
  new()
    - creates a new game
  client_view(game, player)
    - returns a data structure containing player-specific game state
      game      a game data structure
      player    string of player's name
  add_player(game, name)
    - associates the player with a game
      game      a game data structure
      player    string of player's name
  submit_word(game, player, letters, positions)   NOT FINISHED!!
    - updates the game with info when player hit submit or pass
      game        a game data structure
      player      string
      letters     list of letters played, e.g. ["A", "C", "D"]
      positions   list of corresponding positions for letter played, e.g. [2, 17, 32]
  """

  def new do
    %{
      board: make_board(),
      bag: make_bag(),
      letters_left: 100,
      players: [],  # [%{name: "smokey", letters: ["A", "B"], score: 0, turn: 1}]
      dictionary: read_dictionary(),
      winner: nil,
      current_player: "",
      chat_display: "",
      print: ""
    }
  end

  def client_view(game, player) do
    IO.puts("client view\n")

    view = %{
      board: game.board,
      letters_left: game.letters_left,
      player_tiles: get_player_tiles(game, player),
      current_player: game.current_player,
      chat_display: game.chat_display,
      print: game.print
    }
    view
  end



  # Reads a text file of 180,000 words in a dictionary and
  #  returns a list of words in the dictionary.
  #  file taken from: https://scrabutility.com/TWL06.txt
  defp read_dictionary do
    "../../data/words_list.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> (x |> String.replace("\r", "")) end)
  end

  defp get_player_tiles(game, player) do
    IO.puts("get player tiles")
    IO.puts("players")
    IO.inspect(game.players)
    IO.puts(player)

    game.players
    |> Enum.find(fn map -> map.name == player end) |> Map.fetch(:letters)
    |> Tuple.to_list()
    |> List.last()
  end

  # Update the game when player submits a word or passes
  def submit_word(game, player, letters, positions) do
    # for pass, the letters list will be empty
    IO.puts("in submit word")
    IO.inspect(letters)
    IO.inspect(player)
    cond do
      player != game.current_player ->
        game
      length(letters) == 0 ->
        game |> update_player_turn(player)
      true ->
        IO.puts("submit word game.ex")


        # game = game
        # |> put_letters_on_board(letters, positions)
        # |> update_player_score(player, letters, positions)
        # |> update_player_turn(player)
        # |> draw_tile(player)  # should be draw_n_tiles
        # IO.inspect(game.current_player)
        # IO.inspect(game)
        # game

        game
        |> put_letters_on_board(letters, positions)
        |> update_player_score(player, letters, positions)
        |> update_player_turn(player)
        |> draw_tile(player)  # should be draw_n_tiles
    end
  end

  ## NOT DONE
  defp put_letters_on_board(game, letters, positions) do
    # this is not done, should get loop through array
    # of letters and positions
    game
    |> put_letter_on_board(List.first(letters), List.first(positions))
  end

  # places the letter in the game's board object
  defp put_letter_on_board(game, letter, position) do
    # get the map that contains the position
    new_board =
      game.board
      |> Enum.map(&insert_letter(&1, letter, position))
    Map.put(game, :board, new_board)
  end

  # helper function for put_letter_on_board, replaces the
  # letter in the letter_map if position matches
  defp insert_letter(letter_map, letter, position) do
    case letter_map.position == position do
      true -> %{ letter_map | letter: letter }
      false -> letter_map
    end
  end

  ## NOT DONE: this just increases the player's score by 10
  defp update_player_score(game, player, _letters, _positions) do
    new_players =
      game.players |>
        Enum.map(&increase_score(&1, player))
    Map.put(game, :players, new_players)
  end

  defp increase_score(player_map, player) do
    case player_map.name == player do
      true -> %{ player_map | score: player_map.score + 10 }
      false -> player_map
    end
  end

  defp update_player_turn(game, player) do
    next_player = get_next_player(game, player)
    IO.puts("update player turn")
    IO.puts(next_player)
    Map.put(game, :current_player, next_player)
  end

  # verify word in dictionary, returns true or false
  defp is_in_dict(game, word) do
    Enum.member?(game.dictionary, word)
  end

  defp make_player(name) do
    %{name: name, letters: [], score: 0, turn: 0}
  end

  def new_msg_from_room(game, msg) do
    game
    |> Map.put(:chat_display, msg)
  end

  def add_player(game, name) do
    case List.last(game.players) == nil do
      true ->
        player = make_player(name) |> Map.put(:turn, 1)
        Map.put(game, :players, [player])
        |> Map.put(:current_player, name)
        |> draw_tile(name)
        |> draw_tile(name)
        |> draw_tile(name)
        |> draw_tile(name)
        |> draw_tile(name)
        |> draw_tile(name)
        |> draw_tile(name)
      false ->
        player = make_player(name) |> Map.put(:turn, length(game.players) + 1)
        new_players = game.players |> Enum.concat( [player] )
        Map.put(game, :players, new_players)
        |> draw_tile(name)
        |> draw_tile(name)
        |> draw_tile(name)
        |> draw_tile(name)
        |> draw_tile(name)
        |> draw_tile(name)
        |> draw_tile(name)
    end
  end

  # returns the name of the next player as string
  def get_next_player(game, player) do
    # get turn number of current player
    turn_num =
      game.players
      |> Enum.find(fn map -> map.name == player end) |> Map.fetch(:turn)
      |> Tuple.to_list()
      |> List.last()
    # grab the player with the turn + 1 and return the player's name
    game.players
    |> Enum.find(fn map -> map.turn == turn_num + 1 end) |> Map.fetch(:name)
    |> Tuple.to_list()
    |> List.last()
  end

  # generates a starting board for a new game, board is 15 x 15 = 225
  defp make_board() do
    # create list of maps containing the keys: position, letter, and bonus
    board = Enum.to_list(0..224)
      # create a list of maps with positions filled in with 0-224
      |> Enum.map(fn x ->  %{position: x, bonus: "", letter: ""} end)
    board = List.replace_at(board, 2, %{position: 2, bonus: "DL", letter: ""})
    board = List.replace_at(board, 102, %{position: 102, bonus: "DL", letter: ""})
    board = List.replace_at(board, 41, %{position: 41, bonus: "DW", letter: ""})
    board = List.replace_at(board, 111, %{position: 111, bonus: "DW", letter: ""})
    board = List.replace_at(board, 15, %{position: 15, bonus: "TL", letter: ""})
    board = List.replace_at(board, 130, %{position: 130, bonus: "TL", letter: ""})
    board = List.replace_at(board, 75, %{position: 75, bonus: "TW", letter: ""})
    List.replace_at(board, 203, %{position: 203, bonus: "TW", letter: ""})
  end

  defp draw_tile(game, player) do
    IO.puts("in draw tile")
    IO.inspect(game)
    if game.letters_left > 0 do
      draw_tile(game, player, game.letters_left)
    end
  end

  defp draw_tile(game, player, _letters_left) do
    letter_map = game.bag |> Enum.filter(fn x -> x.qty > 0 end) |> Enum.random
    game
    |> pick_from_bag(letter_map)
    |> add_to_player_letters(player, letter_map.letter)
    |> decrement_letters_left
  end

  # select a letter out of the tile bag, return the letter and update value
  defp pick_from_bag(game, letter_map) do
    new_bag =
      game.bag |> Enum.map(&decrement_count_of_letter(&1, letter_map.letter))
    Map.put(game, :bag, new_bag)   #or %{game | bag: new_bag}
  end

  # checks if a letter map has the letter and decrements the count if matches
  defp decrement_count_of_letter(letter_map, letter) do
    case letter_map.letter == letter do
      true -> %{letter_map | qty: letter_map.qty - 1}
      false -> letter_map
    end
  end

  defp add_to_player_letters(game, player, letter) do
    new_players =
      game.players
      |> Enum.map(&find_player_update_letter(&1, player, letter))
    Map.put(game, :players, new_players)
  end

  defp find_player_update_letter(player_map, player, letter) do
    case player_map.name == player do
      true -> %{player_map | letters: Enum.concat(player_map.letters, [letter]) }
      false -> player_map
    end
  end

  defp decrement_letters_left(game) do
    Map.put(game, :letters_left, game.letters_left - 1)
  end

  # generates a bag of tiles for a new game
  defp make_bag do
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