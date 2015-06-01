require 'market_update'
class MarketUpdateTest < ActiveSupport::TestCase
  test 'update auctions' do
    team = FantasticTeam.find_by(name: 'TeamWithUser')
    league = team.league
    auction = Auction.create(end_time: (Time.now + 5).to_datetime)
    bid = Bid.create(salary: 5000000)
    BidRelation.create(from_node: bid, to_node: auction)
    bid.team = team
    auction.player = Player.last
    auction.league = league
    sleep(5)
    Market.update(league)
    Market.create(league)
    assert_equal league.auctions.count >= 3, true
    assert_equal team.contracts.count >= 11, true
  end
end