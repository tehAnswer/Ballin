require 'test_helper'

class BoxScoresTest < ActionDispatch::IntegrationTest
  test 'get all boxscores' do
    token = User.first.auth_code
    get 'api/box_scores', { }, { dagger: token }
    assert_equal 422, response.status

    get 'api/box_scores', { ids: [BoxScore.first.neo_id] }, { dagger: token }
    assert_equal 200, response.status
    hash = parse(response.body)
    assert_equal 1, hash[:box_scores].count

    get 'api/box_scores', { ids: [BoxScore.first.neo_id] }, { }
    assert_equal 401, response.status
  end

  test 'get one boxscore' do
    token = User.first.auth_code
    boxscore = BoxScore.first.auth_code

    get "api/box_scores/#{boxscore.neo_id}", { }, { dagger: token }
    assert_equal 200, response.status
    hash = parse(response.body)

    assert_equal boxscore.points, hash[:box_score][:points]
    assert_equal boxscore.neo_id, hash[:box_score][:neo_id]

    get "api/box_scores/#{boxscore.neo_id}", { }, { }
    assert_equal 401, response.status
  end

end