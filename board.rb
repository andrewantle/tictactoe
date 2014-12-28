# ----------------------------------------------------------------------
# Name: Board
# Abstract: Tic-tac-toe Board class
#
# For example:
#
#   Begin:
#   +- -+- -+- -+
#   | 1 | 2 | 3 |
#   +- -+- -+- -+
#   | 4 | 5 | 6 |
#   +- -+- -+- -+
#   | 7 | 8 | 9 |
#   +- -+- -+- -+
#
#   End:
#   +- -+- -+- -+
#   | X | O | X |
#   +- -+- -+- -+
#   | X | O | X |
#   +- -+- -+- -+
#   | O | X | O |
#   +- -+- -+- -+
#
#   Result: Tie
# ----------------------------------------------------------------------


class Board

  # ----------------------------------------------------------------------
  # Constants
  # ----------------------------------------------------------------------
  
  # Maximum of 3 elements
  BOARD_MAXIMUM_INDEX = 2

  # An empty position is a space (neither X nor O)
  EMPTY_POSITION = ' '


  # ----------------------------------------------------------------------
  # Name: Constructor
  # Abstact: Initialize the board
  # ----------------------------------------------------------------------
  def initialize(current_player)

    # An instance variable for the current player (X or O)
    @current_player = current_player

    # An instance variable for the board, a 3x3 array
    # Declare an array of size 3...
    @board = Array.new(BOARD_MAXIMUM_INDEX + 1) {

      # ...with each element being an array of size 3...
      Array.new(BOARD_MAXIMUM_INDEX + 1) {

        # ...initialized to a space (neither X nor O)
        EMPTY_POSITION }
    }

  end


  # ----------------------------------------------------------------------
  # Name: display
  # Abstact: 1. Draw the current board
  # ----------------------------------------------------------------------
  def display

    # Print the top of the board
    puts "+- - - - - -+"

    # Outer loop through each row
    for row in 0..BOARD_MAXIMUM_INDEX

      # Start the left side cell edge
      print "| "

      # Inner loop through each column
      for column in 0..BOARD_MAXIMUM_INDEX

        # Get the symbol at the current cell
        current_cell = @board[row][column]

        # Empty cell?
        if current_cell == EMPTY_POSITION

          # Yes, print the number of the cell
          print column + (row * 3) + 1

        else

          # No, print the symbol at the current cell
          print current_cell

        end

        # Print the next cell edge to the right
        print " | "

      end
      
      # Print the bottom of the board
      puts "\n+- - - - - -+"

    end

  end

  
  # ----------------------------------------------------------------------
  # Name: board_full
  # Abstact: Determine if the board is full, hence no more pieces to play
  # ----------------------------------------------------------------------
  def board_full

    # Assume the board is full
    result = true

    # Outer loop through each row
    for row in 0..BOARD_MAXIMUM_INDEX

      # Inner loop through each column
      for column in 0..BOARD_MAXIMUM_INDEX

        # Is this cell occupied?
        if @board[row][column] == EMPTY_POSITION

          # No, the board is not full and the game must continue
          result = false

        end

      end

    end

    # Since we found no open positions, the board is full
    return result

  end

  
  # ----------------------------------------------------------------------
  # Name: winner
  # Abstact: Check every row, column, and diagonal for a winner
  # ----------------------------------------------------------------------
  def winner

    # Check every row
    winner = winner_rows()

    # Winner?
    if winner

      # Yes, the game is over
      return winner

    end

    # No row winner, so check every column
    winner = winner_columns()

    # Winner?
    if winner

      # Yes, the game is over
      return winner

    end

    # No row or column winner, so check every diagonal
    winner = winner_diagonals()

    # Winner?
    if winner

      # Yes, the game is over
      return winner

    end

    # Otherwise, no winner
    return

  end


  # ----------------------------------------------------------------------
  # Name: winner_rows
  # Abstact: Check every row for three of the same values
  # ----------------------------------------------------------------------
  def winner_rows

    # Outer loop to look for a winner across the row
    for row in 0..BOARD_MAXIMUM_INDEX

      # Get the player symbol (X or O) that must match
      first_symbol = @board[row][0]

      # Inner loop to look at all elements in the given column
      for column in 1..BOARD_MAXIMUM_INDEX

        # Does this cell match the first symbol?
        if first_symbol != @board[row][column]

          # No, this row IS NOT a winning combination
          break

        # At the end of the row and not all empty?
        # (Make sure we haven't found three empty positions in a column)
        elsif column == BOARD_MAXIMUM_INDEX and first_symbol != EMPTY_POSITION

          # Yes, this row IS a winning combination
          return first_symbol

        end

      end

    end

    # Nope, no winner in any rows
    return

  end

  
  # ----------------------------------------------------------------------
  # Name: winner_columns
  # Abstact: Check every column for three of the same values
  # ----------------------------------------------------------------------
  def winner_columns

    # Outer loop to look for a winner down the column
    for column in 0..BOARD_MAXIMUM_INDEX

      # Get the player symbol (X or O) that must match
      first_symbol = @board[0][column]

      # Inner loop to look at all elements in this column's rows
      for row in 1..BOARD_MAXIMUM_INDEX

        # Does this cell match the first symbol?
        if first_symbol != @board[row][column]

          # No, this column IS NOT a winning combination
          break

        # At the end of this column and not all empty?
        elsif row == BOARD_MAXIMUM_INDEX and first_symbol != EMPTY_POSITION

          # Yes, this column IS a winning combination
          return first_symbol

        end

      end

    end

    # Nope, no winner in any columns
    return

  end

  
  # ----------------------------------------------------------------------
  # Name: winner_diagonals
  # Abstact: Check every diagonal for three of the same values
  # ----------------------------------------------------------------------
  def winner_diagonals

    # Start at the top left, get the player symbol (X or O) to match
    first_symbol = @board[0][0]

    # Traverse the diagonal from top left to bottom right
    for index in 1..BOARD_MAXIMUM_INDEX

      # Does this cell match the first symbol?
      if first_symbol != @board[index][index]

        # No, this diagonal IS NOT a winning combination
        break

      # At the end of this diagonal and not all empty?
      elsif index == BOARD_MAXIMUM_INDEX and first_symbol != EMPTY_POSITION

        # Yes, this diagonal IS a winning combination
        return first_symbol

      end

    end

    # Start at the top right, get the player symbol (X or O) to match
    row = 0                         # Top
    column = BOARD_MAXIMUM_INDEX    # Right
    first_symbol = @board[row][column]

    # Loop through each row (backwards diagonal)
    while row < BOARD_MAXIMUM_INDEX
      
      row += 1      # Down to the next row
      column -= 1   # Left to the next column

      # Does this cell match the first symbol?
      if first_symbol != @board[row][column]

        # No, this diagonal IS NOT a winning combination
        break

      # At the end of this diagonal and not all empty?
      elsif row == BOARD_MAXIMUM_INDEX and first_symbol != EMPTY_POSITION

        # Yes, this diagonal IS a winning combination
        return first_symbol

      end

    end

    # Nope, no winner in any diagonal
    return

  end


  # ----------------------------------------------------------------------
  # Name: ask_player_for_move
  # Abstact: 2. Ask the player for a move
  # ----------------------------------------------------------------------
  def ask_player_for_move(current_player)

    # Player has not made a valid move yet
    played = false
    move = -1

    # Keep processing until a valid move is obtained
    while not played
 
      loop do

        # Ask the player for a move
        puts "Player " + current_player + ": Enter a move (1-9):"

        # Get the player's response, convert the string to an integer
        move = gets.to_i - 1

        # Stop looping if the move is in range
        break if (move >= 0 and move <= 8)

      end

      # ----------------------------------------
      # Column Index ->
      #   0   1   2
      # +- - - - - -+
      # | 1 | 2 | 3 | 0 Row Index
      # +- - - - - -+    |
      # | 4 | 5 | 6 | 1  v
      # +- - - - - -+
      # | 7 | 8 | 9 | 2
      # +- - - - - -+
      #
      # move = "8".to_i - 1 = 8 - 1 = 7
      # @board.size = 3
      # col = 7 % 3 = 1
      # row = (7 - 1) / 3 = 6 / 3 = 2
      # (row, col) = (2, 1) = cell #8
      # ----------------------------------------

      # Convert the number 1-9 into a column 0-2
      # i.e., determine the column index
      column = move % @board.size

      # Convert it into a row
      # i.e., determine the row index
      row = (move - column) / @board.size

      # Valid position; i.e., valid coordinates?
      # (3. Make sure the move is valid)
      if validate_position(row, column)

        # Yes, move the player's piece to this position
        # (4. Store the current move)
        @board[row][column] = current_player

        # Success, the player's turn is complete
        played = true

      end

    end

  end

  
  # ----------------------------------------------------------------------
  # Name: validate_position
  # Abstact: 3. Make sure the move is valid
  # ----------------------------------------------------------------------
  def validate_position(row, column)

    # Assume the move is invalid
    result = false

    # Is this cell within the range of the board?
    if row <= @board.size and column <= @board.size

      # Yes, was this cell previously empty?
      if @board[row][column] == EMPTY_POSITION

        # Yes, the move is valid
        result = true

      else

        # No, this cell wasn't empty
        puts "That position is occupied."

      end

    else

      # No, this cell is off the board
      puts "Invalid position."

    end

    return result

  end


  # ----------------------------------------------------------------------
  # Name: get_next_turn
  # Abstact: Get the next turn
  # ----------------------------------------------------------------------
  def get_next_turn

    # Using an X?
    if @current_player == 'X'

      # Yes, change to O
      @current_player = 'O'

    else

      # No, change to X
      @current_player = 'X'

    end

    return @current_player

  end

end
