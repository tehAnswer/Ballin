require 'test_helper'

class AuctionsTest < ActionDispatch::IntegrationTest

  test "create auction" do
    user = User.find_by(username: "UserWithTeam")
    auction = {
      player_id: user.team.contracts.first.player.neo_id
    }
    post "/api/auctions", { auction: auction }, { dagger: user.auth_code }
    assert_equal 201, response.status
    post "/api/auctions", { auction: auction }, { dagger: user.auth_code }
    assert_equal 422, response.status

    auction[:player_id] = Player.find_by(name: "PlayerWihoutTeam")
    post "/api/auctions", { auction: auction }, { dagger: user.auth_code }
    assert_equal 422, response.status

    post "/api/auctions", { }, { dagger: user.auth_code }
    assert_equal 422, response.status

    post "/api/auctions", { auction: auction }, { }
    assert_equal 401, response.status
  end



  test "get auctions" do
    user = User.find_by(username: "UserWithTeam")
    get "/api/auctions", { }, { dagger: user.auth_code }
    assert_equal 200, response.status

    hash = parse(response.body)
    number_of_pages = [user.team.league.auctions.count.fdiv(BallinAPI::ITEMS_PER_PAGE).ceil, 1].max
    assert_equal number_of_pages, hash[:meta][:total_pages]
    
    get "/api/auctions", { }, { }
    assert_equal 401, response.status
  end



end