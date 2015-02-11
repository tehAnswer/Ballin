require 'test_helper'

class AuctionTest < ActiveSupport::TestCase
  test "max bid" do
  	bid1 = Bid.create!({ salary: 1000 })
  	bid2 = Bid.create!({ salary: 10000 })
  	auction = Auction.create!({end_time: 1.day.from_now})

    auction.bids << BidRelation.create(from_node: bid1, to_node: auction)
    auction.bids << BidRelation.create(from_node: bid2, to_node: auction)

    assert_equal bid2, auction.max_bid 
  end
end
