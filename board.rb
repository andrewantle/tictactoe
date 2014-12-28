# ----------------------------------------------------------------------
# Name: Board
# Abstract: Store the tic-tac-toe board
#
# Begin:
# +- -+- -+- -+
# | 1 | 2 | 3 |
# +- -+- -+- -+
# | 4 | 5 | 6 |
# +- -+- -+- -+
# | 7 | 8 | 9 |
# +- -+- -+- -+
#
# End:
# +- -+- -+- -+
# | X | O | X |
# +- -+- -+- -+
# | X | O | X |
# +- -+- -+- -+
# | O | X | O |
# +- -+- -+- -+
#
# Result: Tie
# ----------------------------------------------------------------------

class Board

  # ----------------------------------------------------------------------
  # Constants
  # ----------------------------------------------------------------------
  
  # Maximum of 3 elements
  BOARD_MAX_INDEX = 2

  # An empty position is a space (neither X nor O)
  EMPTY_POS = ' '


  # ----------------------------------------------------------------------
  # Name: Constructor
  # Abstact: Initialize the board
  # ----------------------------------------------------------------------
  def initialize(current_player)

    # An instance variable for the current player (X or O)
    @current_player = current_player

    # An instance variable for the board, a 3x3 array
    # Declare an array of size 3...
    @board = Array.new(BOARD_MAX_INDEX + 1) {

      # ...with each element being an array of size 3...
      Array.new(BOARD_MAX_INDEX + 1) {

        # ...initialized to a space (neither X nor O)
        EMPTY_POS }
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
    for row in 0..BOARD_MAX_INDEX

      # Start the left side cell edge
      print "| "

      # Inner loop through each column
      for col in 0..BOARD_MAX_INDEX

        # Assign the current cell to s (why s?)
        s = @board[row][col]

        # Empty cell?
        if s == EMPTY_POS

          # Yes, print the number of the cell
          print col + (row * 3) + 1

        else

          # No, print the player at this cell
          print s

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

    # Outer loop through each row
    for row in 0..BOARD_MAX_INDEX

      # Inner loop through each column
      for col in 0..BOARD_MAX_INDEX

        # Is this cell occupied?
        if @board[row][col] == EMPTY_POS

          # No, the board is not full and the game must continue
          return false

        end

      end

    end

    # Since we found no open positions, the board is full
    return true

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
    winner = winner_cols()

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
    for row in 0..BOARD_MAX_INDEX

      # Get the player symbol (X or O) that must match
      first_symbol = @board[row][0]

      # Inner loop to look at all elements in the given column
      for col in 1..BOARD_MAX_INDEX

        # Does this cell match the first symbol?
        if first_symbol != @board[row][col]

          # No, this row IS NOT a winning combination
          break

        # At the end of the row and not all empty?
        # (Make sure we haven't found three empty positions in a column)
        elsif col == BOARD_MAX_INDEX and first_symbol != EMPTY_POS

          # Yes, this row IS a winning combination
          return first_symbol

        end

      end

    end

    # Nope, no winner in any rows
    return

  end

  
  # ----------------------------------------------------------------------
  # Name: winner_cols
  # Abstact: Check every column for three of the same values
  # ----------------------------------------------------------------------
  def winner_cols

    # Outer loop to look for a winner down the column
    for col in 0..BOARD_MAX_INDEX

      # Get the player symbol (X or O) that must match
      first_symbol = @board[0][col]

      # Inner loop to look at all elements in this column's rows
      for row in 1..BOARD_MAX_INDEX

        # Does this cell match the first symbol?
        if first_symbol != @board[row][col]

          # No, this column IS NOT a winning combination
          break

        # At the end of this column and not all empty?
        elsif row == BOARD_MAX_INDEX and first_symbol != EMPTY_POS

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
    for index in 1..BOARD_MAX_INDEX

      # Does this cell match the first symbol?
      if first_symbol != @board[index][index]

        # No, this diagonal IS NOT a winning combination
        break

      # At the end of this diagonal and not all empty?
      elsif index == BOARD_MAX_INDEX and first_symbol != EMPTY_POS

        # Yes, this diagonal IS a winning combination
        return first_symbol

      end

    end

    # Start at the top right, get the player symbol (X or O) to match
    row = 0                 # Top
    col = BOARD_MAX_INDEX   # Right
    first_symbol = @board[row][col]

    # Loop through each row (backwards diagonal)
    while row < BOARD_MAX_INDEX
      
      row += 1              # Down to the next row
      col -= 1              # Left to the next column

      # Does this cell match the first symbol?
      if first_symbol != @board[row][col]

        # No, this diagonal IS NOT a winning combination
        break

      # At the end of this diagonal and not all empty?
      elsif row == BOARD_MAX_INDEX and first_symbol != EMPTY_POS

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

    # Keep processing until a valid move is obtained
    while not played

      # Ask the player for a move
      puts "Player " + current_player + ": Where would you like to play?"

      # Get the player's response, convert the string to an integer
      move = gets.to_i - 1

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
      col = move % @board.size

      # Convert it into a row
      # i.e., determine the row index
      row = (move - col) / @board.size

      # Valid position; i.e., valid coordinates?
      # (3. Make sure the move is valid)
      if validate_position(row, col)

        # Yes, move the player's piece to this position
        # (4. Store the current move)
        @board[row][col] = current_player

        # Success, the player's turn is complete
        played = true

      end

    end

  end

  
  # ----------------------------------------------------------------------
  # Name: validate_position
  # Abstact: 3. Make sure the move is valid
  # ----------------------------------------------------------------------
  def validate_position(row, col)

    # Assume the move is invalid
    result = false

    # Is this cell within the range of the board?
    if row <= @board.size and col <= @board.size

      # Yes, was this cell previously empty?
      if @board[row][col] == EMPTY_POS

        # Yes, the move is valid
        result = true

      else

        # No, the cell was not empty
        puts "That position is occupied."

      end

    else

      # No, the cell is off the board
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
