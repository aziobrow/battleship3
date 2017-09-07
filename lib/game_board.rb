class GameBoard

  attr_reader :board
  attr_accessor :two_unit_ship, :three_unit_ship

  def initialize
    @rows = ['A','B','C','D']
    @columns = ['1','2','3','4']
    @board = setup_board
    @two_unit_ship = []
    @three_unit_ship = []
  end

  def setup_board
    @rows.map do |letter|
      @columns.map do |number|
        letter + number
      end
    end
  end

  def ship_coordinates
    @two_unit_ship + @three_unit_ship
  end

  def find_row_index(space)
    @rows.index(space[0])
  end

  def find_column_index(space)
    @columns.index(space[1])
  end

  def collect_row(space)
    index = find_row_index(space)
    @board[index]
  end

  def collect_column(space)
    index = find_column_index(space)
    column = @board.map { |row| row[index] }
  end


end
