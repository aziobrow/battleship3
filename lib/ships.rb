class Ships

  attr_reader :validated_coordinates, :game_board

  def initialize(validated_coordinates, game_board = GameBoard.new)
    @validated_coordinates = validated_coordinates
    @game_board = game_board
  end

  def three_unit_ship_placement
    @game_board.three_unit_ship << @validated_coordinates
    @game_board.three_unit_ship = @game_board.three_unit_ship.flatten
  end

  def two_unit_ship_placement
    @game_board.two_unit_ship << @validated_coordinates
    @game_board.two_unit_ship = @game_board.two_unit_ship.flatten
  end

  def mark_ship_placement
    if @validated_coordinates.length == 3
      three_unit_ship_placement
    else
      two_unit_ship_placement
    end
  end

end
