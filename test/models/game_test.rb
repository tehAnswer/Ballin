require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test 'missing data' do
    game = Game.new

    game.game_id = 'thefinals' + Date.new.to_s
    game.status = 'Completed'
    game.season_type= 'Regular'
    game.start_date_time = Date.new.to_s
    assert true, game.valid?
    
  end
end