class ComputerPlayer < Player
  attr_reader :board

  def get_move
    if (winning_position = board.winning_spot(@mark))
      winning_position
    else
      @board.available_positions.sample
    end
  end

  def display(updated_board)
    #
    @board = updated_board
  end
end
