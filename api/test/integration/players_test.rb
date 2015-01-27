require 'test_helper'

class PlayersTest < ActionDispatch::IntegrationTest

  test 'get players' do
    token = User.first.auth_code
    get 'api/players', { }, { dagger: token }
    assert_equal 200, response.status
    hash = parse(response.body)
    assert_equal Ballin::PER_PAGE, hash[:players].count
    assert_equal 1, hash[:meta][:page]

    get 'api/players', { page: 2 }, { dagger: .auth_code }
    assert_equal 200, response.status
    hash = parse(response.body)
    assert Ballin::PER_PAGE >= hash[:players].count
    assert_equal 2, hash[:meta][:page]


    get 'api/players', { page: 2000 }, { dagger: token }
    hash = parse(response.body)
    assert_equal 200, response.status
    assert_equal 0, hash[:players].count

    get 'api/players', { }, { }
    response 401, response.status
  end

  test 'get individual player' do
    token = User.first.auth_code
    player = Player.first
    get "api/players/#{player.neo_id}", { }, { dagger: token }
    hash = parse(response.body)
    assert_equal 200, response.status
    assert_equal player.name, hash[:player][:name]
    assert_equal player.box_score_ids.count, hash[:player][:box_score_ids].count

    get "api/players/#{player.neo_id}", { }, { }
    assert_equal 401, response.status

    get 'api/players/999129929', { }, { dagger: token }
    assert_equal 404, response.status
  end


end