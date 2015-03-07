class GamesTest < ActionDispatch::IntegrationTest
  test 'get games by date' do
    auth_code = User.first.auth_code

    get '/games', { dateFormatted: "" }, { dagger: auth_code }
    hash = parse(response.body)
    assert_equal 200, response.status
    assert_equal 0, hash.games.count

    get '/games', { dateFormatted: "20150207" }, { dagger: auth_code }
    hash = parse(response.body)
    assert_equal 200, response.status
    assert_equal 1, hash.games.count

    get '/games', { dateFormatted: "20150207" }, { }
    assert_equal 401, response.status
  end

  test 'get games by id' do
    auth_code = User.first.auth_code
    game_id = Game.first.neo_id

    get '/games', { ids: [game_id] }, { dagger: auth_code }
    hash = parse(response.body)
    assert_equal 200, response.status
    assert_equal 1, hash.games.count
  end

end