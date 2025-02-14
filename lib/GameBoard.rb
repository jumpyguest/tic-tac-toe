require_relative 'Player'

class GameBoard
  LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

  attr_accessor :board
  def initialize
    # Board is represented by a one-dimensional array. Index 0 not used.
    @board = Array.new(10)
    @current_player = nil
  end

  def print_board
    col_separator, row_separator = " | ", '========='
    row_positions = [[1 ,2, 3], [4, 5, 6], [7, 8, 9]]

    # Get the value to be displayed for each position
    value_for_position = lambda{|position| @board[position] ? @board[position] : position}
    # Invoke Array.map to generate an array/row based on value_for_position value
    row_for_display = lambda{|row| row.map(&value_for_position).join(col_separator)}
    # Invoke Array.map to generate an array of rows with value for each position
    rows_for_display = row_positions.map(&row_for_display)
    # Display the board
    puts rows_for_display.join("\n" + row_separator + "\n")
  end

  def get_free_positions
    (1..9).select{|pos| @board[pos].nil?}
  end

  def play
    player_X = Player.new('X', self)
    player_O = Player.new('O', self)

    @current_player = player_X
    self.print_board
    loop do
      @current_player.select_position
      if win?(current_player)
        puts "\nPlayer #{current_player.player_id} wins!!!"
        break
      elsif get_free_positions.empty?
        puts "\nDraw!!!"
        break
      end
      @current_player = @current_player.player_id == 'X' ? player_O : player_X
    end
  end

  private

  attr_accessor :current_player

  def win?(player)
    LINES.each do |line|
      if line.difference(player.player_positions).empty?
        return true
      end
    end
    return false
  end
end