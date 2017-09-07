require_relative 'game_board'

class Coordinates

  attr_reader :coordinates, :game_board

  def initialize(coordinates_to_validate, game_board = GameBoard.new)
    @coordinates = coordinates_to_validate
    @game_board = game_board
  end

  def all_spaces
    @game_board.board.flatten
  end

  def same_row?
    row = @game_board.collect_row(@coordinates[0])
    (row & @coordinates) == @coordinates
  end

  def same_column?
    column = @game_board.collect_column(@coordinates[1])
    (column & @coordinates) == @coordinates
  end

  def count_coordinate_range
    sorted = @coordinates.sort
    if same_row?
      sorted[1][1].to_i - sorted[0][1].to_i
    else
      sorted[1][0].codepoints[0] - sorted[0][0].codepoints[0]
    end
  end

  def exist_on_gameboard?
    (all_spaces & @coordinates) == @coordinates
  end

  def already_occupied?
    occupied_spaces = @game_board.ship_coordinates
    occupied_spaces.each do |space|
      return true if @coordinates.include?(space)
    end
    false
  end

  def three_coordinates?
    range = count_coordinate_range
    return true if range == 2
    false
  end

  def add_third_coordinate_for_same_row
    first_coordinate = @coordinates[0]
    middle_coordinate = first_coordinate.next
    third_coordinate = middle_coordinate.next
    three_coordinates = [first_coordinate, middle_coordinate, third_coordinate]
  end

  def add_third_coordinate_for_same_column
    column = @game_board.collect_column(@coordinates[0])
    index = @game_board.find_row_index(@coordinates[0])
    first_coordinate = column[index]
    middle_coordinate = column[index + 1]
    third_coordinate = column[index + 2]
    three_coordinates = [first_coordinate, middle_coordinate, third_coordinate]
  end

  def generate_coordinates
    #make sure this is followed by a validity checker with all three coordinates
    if three_coordinates? && same_row?
      add_third_coordinate_for_same_row
    elsif three_coordinates? && same_column?
      add_third_coordinate_for_same_column
    else
      @coordinates
    end
  end

  def invalid_placement?
    return true if @coordinates.length != 2
    return true if same_column? && same_row?
    return true if !(same_column? or same_row?)
    return true if already_occupied?
    return true if count_coordinate_range > 2
    return true if !exist_on_gameboard?
    return true if count_coordinate_range == 2 and @three_unit_ship == true
    return true if count_coordinate_range == 1 and @two_unit_ship == true
    false
  end



end
