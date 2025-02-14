class Player
  attr_reader :player_id, :player_positions
  def initialize(id, game_board)
    @player_positions = Array.new
    @player_id = id
    @game_board = game_board
  end

  def update_position(position)
    @player_positions.push(position)
  end

  def select_position
    while !@game_board.get_free_positions.empty? do
      print "\nPlayer #{self.player_id} Enter your position: "
      position = gets.chomp.to_i
      if position == 0 || position > 9 || @game_board.board[position] != nil
        puts "Unavailable position. Please try again."
      else
        @game_board.board[position] = self.player_id
        self.update_position(position)
        @game_board.print_board
        break
      end
    end
  end
end