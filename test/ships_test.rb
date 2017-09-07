require_relative 'test_helper'
require './lib/ships'
require './lib/coordinates'

class ShipsTest < Minitest::Test

  def test_it_initializes_with_valid_coordinates_and_game_board
    validated_coordinates = Coordinates.new(['A1', 'A2']).generate_coordinates
    ships = Ships.new(validated_coordinates)

    assert_instance_of Ships, ships
    assert_instance_of GameBoard, ships.game_board
    assert_equal ['A1', 'A2'], ships.validated_coordinates
  end

  def test_it_knows_placement_of_three_unit_ship
    validated_coordinates = Coordinates.new(['B2', 'D2']).generate_coordinates
    ships = Ships.new(validated_coordinates)
    ships.three_unit_ship_placement

    assert_equal ['B2', 'C2', 'D2'], ships.game_board.three_unit_ship

    validated_coordinates = Coordinates.new(['C1', 'C3']).generate_coordinates
    ships = Ships.new(validated_coordinates)
    ships.three_unit_ship_placement

    assert_equal ['C1', 'C2', 'C3'], ships.game_board.three_unit_ship
  end

  def test_it_knows_placement_of_two_unit_ship
    validated_coordinates = Coordinates.new(['A2', 'A3']).generate_coordinates
    ships = Ships.new(validated_coordinates)
    ships.two_unit_ship_placement

    assert_equal ['A2', 'A3'], ships.game_board.two_unit_ship

    validated_coordinates = Coordinates.new(['B4', 'C4']).generate_coordinates
    ships = Ships.new(validated_coordinates)
    ships.two_unit_ship_placement

    assert_equal ['B4', 'C4'], ships.game_board.two_unit_ship
  end

  def test_it_can_mark_ship_placement_by_size
    validated_coordinates = Coordinates.new(['D3', 'D4']).generate_coordinates
    ships = Ships.new(validated_coordinates)
    ships.mark_ship_placement

    assert_equal ['D3', 'D4'], ships.game_board.two_unit_ship
    assert_empty ships.game_board.three_unit_ship

    validated_coordinates = Coordinates.new(['B1', 'D1']).generate_coordinates
    ships = Ships.new(validated_coordinates)
    ships.mark_ship_placement

    assert_equal ['B1', 'C1', 'D1'], ships.game_board.three_unit_ship
    assert_empty ships.game_board.two_unit_ship
  end

end
