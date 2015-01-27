require 'test_helper'

class LeaguesTest < ActionDispatch::IntegrationTest
    test 'league creation' do
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