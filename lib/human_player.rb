class HumanPlayer < Player
  def get_move
    puts "Where would you like to move: "
    move = gets.chomp

    move.scan(/\d+/).take(2).map { |pos| pos.to_i }
  end

  def display(board)
    puts board.render
  end
end
