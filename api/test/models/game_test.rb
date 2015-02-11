require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test 'missing data' do
    game = Game.new
    game.game_id = 'thefinals' + DateTime.new.to_s
    game.status = 'Completed'
    game.season_type = 'Regular'
    game.start_date_time = DateTime.new.to_s
    assert_equal false, game.valid?
    game.date_formatted = DateTime.new.strftime('%Y%m%d')
    assert_equal true, game.valid?  
  end

  test 'incoherent data' do
    game = Game.new
    game.game_id = 'thefinals' + DateTime.new.to_s
    game.status = 'Completed'
    game.season_type = 'Regular'
    game.start_date_time = DateTime.new.to_s
    game.date_formatted = "Je\nJeje\nJejeje"
    assert_equal false, game.valid?
    game.date_formatted = "20140101"
    assert_equal false, game.valid?
  end
end