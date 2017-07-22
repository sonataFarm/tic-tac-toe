require_relative 'board'
require_relative 'player'
require_relative 'human_player'
require_relative 'computer_player'

# TODO: Board => distinguish public/private API
# TODO: Board => wrap pos in struct

AVAILABLE_MARKS = [:X, :O]

class Game
  attr_reader :board, :current_player, :player1, :player2

  def initialize(options = {})
    options = defaults.merge(options)

    @board = options[:board]
    @player1, @player2 = options[:players]

    assign_marks
    @current_player = player1
  end

  def defaults
    {
      board: Board.new,
      players: [HumanPlayer.new, ComputerPlayer.new]
    }
  end

  # def initialize(player1, player2)
  #   @board = Board.new
  #
  #   @player1 = player1
  #   @player2 = player2
  #   assign_marks(@player1, @player2)
  #
  #   @current_player = player1
  # end

  def assign_marks
    marks = AVAILABLE_MARKS.shuffle

    [player1, player2].each_with_index do |player, idx|
      player.mark = marks[idx]
    end
  end

  def play
    until board.over?
      play_turn
    end
  end

  def play_turn
    move(current_player)
    switch_players!
  end

  def move(player)
    player.display(board)

    to = player.get_move
    until board.valid_move(to) do
      puts "#{to.inspect} is not a valid move."
      to = player.get_move
    end

    board.place_mark(to, player.mark)
  end

  def switch_players!
    @current_player =
      if @current_player == @player1
        @player2
      else
        @player1
      end
  end
end

# debugging
#
# nate = HumanPlayer.new('Nate')
# comp = ComputerPlayer.new('Computer')
# game = Game.new(nate, comp)
# game.play
