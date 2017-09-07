require './lib/game_board'
require './lib/display_board'

class ShotsFired

  attr_reader :all_shots, :shots_board, :shots_display

  def initialize(game_board)
    @shots_board = game_board
    @shots_display = DisplayBoard.new(@shots_board)
    @all_shots = []
  end

  def two_unit_ship_sunk?
    two_ship = @shots_board.two_unit_ship
    (two_ship & all_shots) == two_ship
  end

  def three_unit_ship_sunk?
    three_ship = @shots_board.three_unit_ship
    (three_ship & all_shots) == three_ship
  end

  def win?
    two_unit_ship_sunk? and three_unit_ship_sunk?
  end

  def render_shot_on_game_board(shot)
    @shots_display.render_shot(shot)
  end

  def duplicate_shot?(shot)
    @all_shots.include?(shot)
  end

  def shot_response(shot)
    hits = @shots_board.ship_coordinates
    if hits.include?(shot)
      UserInteraction.new.hit_message
    else
      UserInteraction.new.miss_message
    end
  end

  def valid_shot_is_fired(shot)
    all_shots << shot
    shot_response(shot)
    render_shot_on_game_board(shot)
  end

end
