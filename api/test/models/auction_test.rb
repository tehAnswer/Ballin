require 'test_helper'

class AuctionTest < ActiveSupport::TestCase
  test "max bid" do
  	bid1 = Bid.create!({ salary: 500000 })
  	bid2 = Bid.create!({ salary: 600000 })
  	auction = Auction.create!({end_time: 1.day.from_now})
    
    BidRelation.create(from_node: bid1, to_node: auction)
    BidRelation.create(from_node: bid2, to_node: auction)


    assert_equal bid2, auction.max_bid 
  end
end
