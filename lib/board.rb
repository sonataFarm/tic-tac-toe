class Board
  attr_reader :grid, :rows, :cols, :marks

  def initialize(custom_grid = nil)
    if custom_grid
      @grid = custom_grid
    else
      @grid = Array.new(3) { Array.new(3) }
    end
    @rows = @grid.length
    @cols = @grid[0].length
    @marks = [:X, :O]
  end

  def [](pos)
    # pos is [row, col]
    row, col = pos
    grid[row][col]
  end

  def []=(pos, mark)
    # pos is [row, col]
    row, col = pos
    @grid[row][col] = mark
  end

  def place_mark(pos, mark)
    self[pos] = mark
  end

  def remove_mark(pos)
    self[pos] = nil
  end

  # => TicTacToeRules
  def valid_move(to)
    empty?(to) && within?(to)
  end

  def empty?(pos)
    self[pos].nil?
  end

  def within?(pos)
    row, col = pos

    return false if row < 0 || row >= rows
    return false if col < 0 || col >= cols

    true
  end

  def marked?(pos)
    !empty?(pos)
  end

  # => TicTacToeRules
  def winner
    # return winning mark or nil if none
    row_winner || col_winner || diagonal_winner
  end

  # => TicTacToeRules
  def over?
    row_winner || col_winner || diagonal_winner || board_full?
  end

  # => TicTacToeRules
  def row_winner
    # return winning symbol or nil
    grid.each do |row|
      return row[0] if row.all? { |cell| cell == row[0] && !cell.nil? }
    end

    nil
  end

  # => TicTacToeRules
  def col_winner
    # return winning symbol or nil
    grid[0].each_with_index do |cell, idx|
      return cell if grid.all? { |row| cell == row[idx] && !row[idx].nil? }
    end

    nil
  end

  # => TicTacToeRules
  def diagonal_winner
    # return winning symbol or nil
    left_diagonal_winner || right_diagonal_winner
  end

  # => TicTacToeRules
  def left_diagonal_winner
    # return winning symbol or nil
    top_left = self[[0, 0]]
    indices = 0...rows

    winner = indices.all? do |idx|
      pos = [idx, idx]
      self[pos] == top_left && !empty?(pos)
    end

    winner ? top_left : nil
  end

  #  [ [X O X]
  #    [O O X]
  #    [X X X] ]

  # => TicTacToeRules
  def right_diagonal_winner
    # return winning symbol or nil
    top_right = self[[0, -1]]
    indices = 0...rows

    winner = indices.all? do |idx|
      row = idx
      col = -1 - idx
      pos = [row, col]

      self[pos] == top_right && !empty?(pos)
    end

    winner ? top_right : nil
  end

  def board_full?
    grid.all? do |row|
      row.none? do |cell|
        cell.nil?
      end
    end
  end

  def render
    grid.reduce('') do |grid_string, row|
      printables = row.map do |cell|
        if cell == nil
          '-'
        else
          cell.to_s
        end
      end

      row_string = printables.join(' ')
      grid_string << row_string + "\n"
    end
  end

  # TODO ???
  def winning_spot(mark)
    # return position if adding given mark would result in a win,
    # else nil
    test_board = Board.new(grid)
    test_board.available_positions.each do |pos|
      test_board.place_mark(pos, mark)
      if test_board.winner
        return pos
      else
        test_board.remove_mark(pos)
      end
    end

    nil
  end

  def available_positions
    # generate array of all available positions
    available_positions = []
    (0...rows).each do |row|
      (0...cols).each do |col|
        position = [row, col]
        available_positions << position if empty?(position)
      end
    end

    available_positions
  end
end
