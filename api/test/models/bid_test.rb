require 'test_helper'

class BidTest < ActiveSupport::TestCase
  test "minum salary" do
    # This in China or Spain may not pass.
    bid = Bid.create(salary: 1)
    assert_equal false, bid.valid?
    bid.salary = 500_000
    assert_equal true, bid.valid?
  end
end
