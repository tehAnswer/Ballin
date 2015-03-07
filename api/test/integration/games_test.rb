class GamesTest < ActionDispatch::IntegrationTest
  test 'get games by date' do
    auth_code = User.first.auth_code
    date_formatted = DateTime.new.strftime('%Y%m%d')

    get '/api/games', { date_formatted: "" }, { dagger: auth_code }
    hash = parse(response.body)
    assert_equal 200, response.status
    assert_equal 0, hash[:games].count

    get '/api/games', { date_formatted: date_formatted }, { dagger: auth_code }
    hash = parse(response.body)
    assert_equal 200, response.status
    assert_equal 1, hash[:games].count

    get '/api/games', { date_formatted: date_formatted }, { }
    assert_equal 401, response.status
  end

  test 'get games by id' do
    auth_code = User.first.auth_code
    game_id = Game.first.neo_id

    get '/api/games', { ids: [game_id] }, { dagger: auth_code }
    hash = parse(response.body)
    assert_equal 200, response.status
    assert_equal 1, hash[:games].count

    get "/api/games/#{game_id}", { }, { dagger: auth_code }
    hash = parse(response.body)
    assert_equal 200, response.status
  end

end