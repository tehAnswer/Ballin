require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
    test 'correct login' do
      token = User.find_by(username: "Eric Cartman").auth_code
      post '/api/users/sign_in', { email_or_username: "Eric Cartman", password: "ihatekyle" }
      assert_equal 201, response.status
      post '/api/users/sign_in', { email_or_username: "ihatekyle@gmail.com", password: "ihatekyle" }
      assert_equal 201, response.status
      hash = parse(response.body)
      assert_equal token, hash[:user][:auth_code]
      assert_equal "Eric Cartman", hash[:user][:username]
      assert_equal nil, hash[:user][:password]
    end

    test 'incorrect login' do
       post '/api/users/sign_in', { email_or_username: "fake", password: "fakefakefake" }
       assert_equal 401, response.status
    end

    test 'missing data' do
      post '/api/users/sign_in', { }
      assert_equal 401, response.status
    end

    test 'login after change password' do
      cartman = User.find_by(username: "Eric Cartman")
      cartman.password= "fatgainer4000"
      cartman.save
      post '/api/users/sign_in', { email_or_username: "Eric Cartman", password: "ihatekyle" }
      assert_equal 401, response.status
      post '/api/users/sign_in', { email_or_username: "Eric Cartman", password: "fatgainer4000" }

      assert_equal 201, response.status
      cartman.password= "ihatekyle"
      cartman.save

      post '/api/users/sign_in', { email_or_username: "Eric Cartman", password: "ihatekyle" }
      assert_equal 201, response.status
      post '/api/users/sign_in', { email_or_username: "Eric Cartman", password: "fatgainer4000" }
      assert_equal 401, response.status
    end

end