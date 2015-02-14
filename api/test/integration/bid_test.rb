require 'test_helper'

class BidsTest < ActionDispatch::IntegrationTest

  test "new bid" do
    auth_code = User.find_by(username: "UserWithTeam").auth_code
    bid = {
      salary: 100_000,
      auction_id: -1
    }
    post '/api/bids', { bid: bid }, { dagger: auth_code }
    assert_equal 422, response.status
    auction = Auction.create(end_time: 2.day.from_now)
    bid[:auction_id] = auction.neo_id
    bid[:salary] = 1_000_000
    post '/api/bids', { bid: bid }, { dagger: auth_code }
    assert_equal 201, response.status
  end

  test "missing param" do
    auth_code = User.first.auth_code
    post '/api/bids', { }, { dagger: auth_code }
    assert_equal 422, response.status
  end

  test "my bids" do
    auth_code = User.first.auth_code
    get '/api/bids', { }, { dagger: auth_code }
    assert_equal 200, response.status
    get '/api/bids', { }, { dagger: "fake" }
    assert_equal 401, response.status
    get '/api/bids', { }, { }
    assert_equal 401, response.status
  end

  test "bid on a close auction" do
    auth_code = User.first.auth_code
    auction = Auction.create!(end_time: 1.day.ago)
    bid = {
      salary: 500_000,
      auction_id: auction.neo_id
    }
    post '/api/bids', { bid: bid }, { dagger: auth_code }
    assert_equal 422, response.status
  end

end