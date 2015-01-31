require 'test_helper'

class LeaguesTest < ActionDispatch::IntegrationTest
    test 'league creation' do
      league = {
        name: "UniqueLeagueName"
      }
      post 'api/leagues', { league: league }, { dagger: User.admin.first.auth_code }
      assert_equal 201, response.status
      post 'api/leagues', { league: league }, { dagger: User.first.auth_code }
      assert_equal 401, response.status
      post 'api/leagues', { league: league }, { dagger: User.admin.first.auth_code }
      assert_equal 422, response.status
    end

    test 'individual league' do
      league = League.first
      get "api/leagues/#{league.neo_id}", { },  { dagger: User.first.auth_code }
      assert_equal 200, response.status
      hash = parse(response.body)
      assert_equal league.name, hash[:league][:name]
      assert_equal 2, hash[:league][:conference_ids].count
      get 'api/leagues/181818181881', { },  { dagger: User.first.auth_code }
      assert_equal 404, response.status
    end

    test 'get leagues' do
      get 'api/leagues', { }, { dagger: User.first.auth_code }
      assert_equal 200, response.status
      hash = parse(response.body)
      assert_equal 1, hash[:leagues].count
      assert_equal 1, hash[:meta][:pages]
      assert_equal 1, hash[:meta][:total_pages]
      assert_equal Ballin::PER_PAGE, hash[:meta][:per_page]

      get 'api/leagues', { page: 9999 }, { dagger: User.first.auth_code }
      assert 200, response.status
      hash = parse(response.body)
      assert_equal 0, hash[:leagues].count
    end

    test 'get leagues without api_key' do
      get 'api/leagues', { }, { }
      assert_equal 401, response.status
    end

    test 'get leagues with a old api_key' do
      user = User.first
      old_token = user.update_auth_code

      get 'api/leagues', { }, { dagger: old_token }
      assert_equal 401, response.status
      get 'api/leagues', { }, { dagger: user.auth_code }
      assert_equal 200, response.status
    end

end