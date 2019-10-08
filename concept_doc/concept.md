# Word Tiles, Building a Scrabble-like Word Game with Elixir, Phoenix, and React
Authors: Melisa Brown, Chuhan Zhang


## Game Overview
We are building a scrabble-like board game named “Word Tiles” that can be 
played with 2-4 players, using React, Phoenix, and Elixir. Upon entering the 
game’s main page, users will be asked to enter their names and have the option 
of joining an already occupied game room or starting their own game room. The 
player that creates a game room gets to decide when the game will start, i.e. 
whether 2, 3, or 4 players will participate in the game. Once a game has 
started, additional players cannot join. Within a game room, players in the 
game have access to a game chat that is unique for the game. 

## Game Specifics
The object of the game is to accumulate the most points by forming words on a 
15 x 15 board, where a slot corresponds to a letter. In total there are 100 
letter tiles available for play. Each letter has a point value and distribution 
that roughly corresponds to its frequency in a given language. The less 
frequently a letter occurs in the language, the higher the point value. For 
English, the distribution and points for letters are:

![alt 
text](https://github.com/brownmelisa/word_tiles/blob/master/concept_doc/letter_v
alues.png)

The game starts by drawing 7 tiles (without replacement) from the “bag” of 100 
tiles for each of the players. The turn order will be randomly generated for 
each game. Players take turns forming words by placing the tiles on the board. 
A turn consists of playing a word, exchanging some or all letter tiles, or 
passing. The last two options will not yield any points.  As long as there are 
still tiles left in the “bag”, the game will automatically replenish the number 
of tiles played in a turn, so that players will always have 7 tiles available 
for play. If there are no tiles left in the bag, the game will continue with 
whatever tiles are in play. The game ends when no tiles are left in the “bag” 
and A) a player has used all of his/her letters or B) no valid word can be 
formed by any of the players. The player with the most points at the end of the 
game wins.

Rules for tile placement. At the start of the game, the first player must form 
a word that uses the center position on the board indicated by a star. Words 
must be at least two letters long and be oriented left to right or top to 
bottom. Words cannot be formed diagonally, right to left, or bottom to top. All 
letters in the word must fit on the board and use at least one letter tile that 
is already in play.
Scoring. The score for a turn is the sum of the points for letters in the word 
played. This includes letters that were already on the board and any additional 
letters played. The game board has bonus positions labeled “DL”, “DW”, “TL”, 
and “TW” corresponding to double letter, double word, triple letter, and triple 
word. Placing a tile on any of these positions will adjust the word score 
accordingly. For example, playing the word “CAT” on normal positions totals: C 
=> 2 + A => 1 + T => 1 = 4 points. If the position of the letter “C” had a “TL” 
the word would be worth (2 * 3) + 1 + 1 = 8 points. If the position had a “TW”, 
the word would be worth (2 + 1 + 1) * 3 = 12 points. Additionally, players get 
a 50 point bonus for playing all seven tiles in a turn.

## Additional Functionality (time permitting)
### Sounds. We want to implement non-trivial sound effects in game play. The 
effects include at least button click sounds, the sound when word is played and 
background music. If we have more time, the sound when word is played can be 
differentiated by if the word played is valid and the number of points the word 
is worth.  If the word is worth more points, a more unique/merrier sound is 
played. In addition, we should allow users to turn on/off the sound effect.
Language Selection. We want to try to implement the scrabble game in different 
languages that have similar alphabets to English. The game provide selection of 
language when player enters game, this will change the tiles available and the 
dictionary to check the played word with.

### Leaderboard. we’d like to implement a server-wide leaderboard. The 
leaderboard would rank the top players by number of games they won. This would 
require implementing a database on the server.

## Expected Challenges
### Challenge 1. Multiplayer server side logic: Our game is designed for 2-4 
people to play. The server need to sync the states of 2-4 players. The server 
also need to ignore or prevent moves coming from other players(browsers) when 
one player has current turn. The challenge is to enforce the turn-based rules 
on different players. Also once targeted number of players have joined the 
table, server need to prevent more players from joining table. 

### Challenge 2. Chat room server side implementation: As stated in the 
instruction, an unlimited number of people should able to observe the game and 
need to communicate with each other by text chat. Implementing the observer 
logic that can only let them type text messages without giving them permission 
to change the current game state may be challenging.

### Challenge 3. Check the validity of played word: Checking of validity need 
to be implemented on the server side. So we need to obtain a dictionary of 
words in English(later on other languages such as French, Spanish) or 
delegating word checking to other online dictionary sources. We think it may be 
difficult to obtain such a dictionary file without copyright infringement. 
Delegation may cost money or difficult to implement as well.
