require 'test_helper'

class RegisterTest < ActionDispatch::IntegrationTest

  test 'correct register' do
    user = {
      login: {
        username: "Kenny",
        password: "p00rp00r",
        email: "kenny@freehost.co.uk"
      }
    }

    post '/api/users', user, { }
    assert_equal 201, response.status
    hash = parse(response.body)
    assert_equal "Kenny", hash[:user][:username]
    assert_equal "kenny@freehost.co.uk", hash[:user][:email]
  end

  test 'username and email taken' do
    user = {
      login: {
        username: "Kenny",
        password: "p00rp00r",
        email: "kenny@freehost.co.uk"
      }
    }

    post '/api/users', user, { }
    assert_equal 422, response.status
  end

  test 'wrong email' do
    user = {
      login: {
        username: "??????",
        password: "p00rp00r",
        email: "questionmarkquestionmark@"
      }
    }

    post '/api/users', user, { }
    assert_equal 422, response.status
  end

  test 'missing data' do
    post '/api/users', { }, { }
    assert_equal 422, response.status    
  end


end