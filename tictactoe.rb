# ----------------------------------------------------------------------
# Name: tictactoe
# Abstract: Main program that starts the game (the Driver)
# ----------------------------------------------------------------------

# ----------------------------------------------------------------------
# Includes
# ----------------------------------------------------------------------
require 'board.rb'


# Let's get ready to rumble!
puts "Starting tic-tac-toe..."

# Randomly pick an initial player (either X or O)
players = ['X', 'O']
current_player = players[rand(2)]

# Create an instance of the Board class
board = Board.new(current_player)

# Display the initial blank board
# (1. Draw the current board)
board.display()
puts


# The main game loop
# (Until the board is full AND there is no winner)
#  While the board isn't full AND there is no winner
while not board.board_full() and not board.winner()

  # Prompt the current player for a move
  # (2. Ask the player for a move)
  board.ask_player_for_move(current_player)

  # Get the next player
  # (3. Make sure the move is valid), (4. Store the current move)
  current_player = board.get_next_turn()

  # (1. Draw the current board)
  board.display()
  puts

end


# Is there a winner?
if board.winner()

  # Yes, print the winner's name
  puts "Player " + board.get_next_turn() + " wins."

else

  # No, tie
  puts "Tie Game."

end

# Wah wah wahhh
puts "Game Over!"
