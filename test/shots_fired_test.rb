require_relative 'test_helper'
require './lib/shots_fired'
require './lib/user_interaction'

class ShotsFiredTest < Minitest::Test
  def test_it_exists_and_initializes_with_game_board_and_display
    shots_board = GameBoard.new
    shots = ShotsFired.new(shots_board)

    assert_instance_of GameBoard, shots.shots_board
    assert_instance_of DisplayBoard, shots.shots_display
    assert_equal [], shots.all_shots
  end

  def test_fired_shots_populates_all_shots
    shots_board = GameBoard.new
    shots = ShotsFired.new(shots_board)
    shots.valid_shot_is_fired('A1')

    assert_equal ['A1'], shots.all_shots

    shots.valid_shot_is_fired('C3')

    assert_equal ['A1', 'C3'], shots.all_shots
  end

  def test_it_knows_two_unit_ship_is_sunk
    shots_board = GameBoard.new
    shots = ShotsFired.new(shots_board)
    shots_board.two_unit_ship = ['C2', 'C3']
    shots.valid_shot_is_fired('C2')

    refute shots.two_unit_ship_sunk?

    shots.valid_shot_is_fired('C3')

    assert shots.two_unit_ship_sunk?
  end

  def test_it_knows_two_unit_ship_is_sunk
    shots_board = GameBoard.new
    shots = ShotsFired.new(shots_board)
    shots_board.three_unit_ship = ['A4', 'B4', 'C4']
    shots.valid_shot_is_fired('B4')

    refute shots.two_unit_ship_sunk?

    shots.valid_shot_is_fired('C4')
    shots.valid_shot_is_fired('A4')

    assert shots.three_unit_ship_sunk?
  end

  def test_it_knows_win
    shots_board = GameBoard.new
    shots = ShotsFired.new(shots_board)

    shots_board.two_unit_ship = ['A2', 'B2']
    shots_board.three_unit_ship = ['C1', 'C2', 'C3']

    shots.valid_shot_is_fired('B2')

    refute shots.win?

    shots.valid_shot_is_fired('A2')
    shots.valid_shot_is_fired('C3')
    shots.valid_shot_is_fired('C1')
    shots.valid_shot_is_fired('C2')

    assert shots.win?
  end

  def test_render_shot_on_gameboard_renders_shot_in_addition_to_previous_shots
    shots_board = GameBoard.new
    shots = ShotsFired.new(shots_board)

    shots.render_shot_on_game_board('B4')
  end

  def test_it_knows_duplicate_shots
    shots_board = GameBoard.new
    shots = ShotsFired.new(shots_board)
    shots.all_shots = ['D2', 'C4']

    refute shot.duplicate_shot?('B1')
    assert shot.duplicate_shot?('C4')
  end

  # def test_shot_response_knows_hit_or_miss_and_provides_appropriate_message
  #   shots_board = GameBoard.new
  #   shots = ShotsFired.new(shots_board, 'B2')
  #
  #   #check for message about hits here, shots.shot_response(['B2'])
  #
  #   more_shots = ShotsFired.new(shots_board, 'C3')
  #
  #   #check for message about miss here, shots.shot_response(['B2'])
  # end

end
