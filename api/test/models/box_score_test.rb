require 'test_helper'

class BoxScoreTest < ActiveSupport::TestCase
  test 'coherent data' do
    boxscore = BoxScore.create(points: 8)
    boxscore.assists = 2
    boxscore.ofr = 1
    boxscore.steals = 3
    boxscore.fga = 4
    boxscore.fgm = 4
    boxscore.lsa = 0
    boxscore.lsm = 0
    boxscore.turnovers = 3

    assert_equal true, boxscore.valid?
  end

  test 'incoherent data' do
    boxscore = BoxScore.new
    boxscore.points = 1
    assert_equal false, boxscore.valid?
    boxscore.ftm = 1
    assert_equal false, boxscore.valid?
    boxscore.fta = 1
    boxscore.is_started = false
    boxscore.points = boxscore.points_made
    assert_equal true, boxscore.valid?
  end
end
