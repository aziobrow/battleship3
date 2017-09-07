require_relative 'test_helper'
require './lib/game_board'

class GameBoardTest < Minitest::Test

  def test_it_initializes_into_array_of_four_arrays
    game_board = GameBoard.new

    assert_instance_of Array, game_board.board
    assert_equal 4, game_board.board.count
    assert_equal [], game_board.two_unit_ship
    assert_equal [], game_board.three_unit_ship

    assert_equal ['A1', 'A2', 'A3', 'A4'], game_board.board[0]
    assert_equal ['B1', 'B2', 'B3', 'B4'], game_board.board[1]
    assert_equal ['C1', 'C2', 'C3', 'C4'], game_board.board[2]
    assert_equal ['D1', 'D2', 'D3', 'D4'], game_board.board[3]
  end

  def test_it_knows_all_coordinates_where_ships_are_placed
    game_board = GameBoard.new
    game_board.two_unit_ship = ['A1','A2']
    game_board.three_unit_ship = ['D2', 'D3', 'D4']

    assert_equal ['A1', 'A2', 'D2', 'D3', 'D4'], game_board.ship_coordinates
  end

  def test_it_can_find_row_index_of_space
    game_board = GameBoard.new

    assert_equal 1, game_board.find_row_index('B3')
    assert_equal 3, game_board.find_row_index('D4')
  end

  def test_it_can_find_column_index_of_space
    game_board = GameBoard.new

    assert_equal 2, game_board.find_column_index('B3')
    assert_equal 3, game_board.find_column_index('D4')
  end

end
