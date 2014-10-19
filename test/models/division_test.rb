require 'test_helper'

class DivisionTest < ActiveSupport::TestCase
  test "the truth" do
     division = Division.new
     assert_equal 0, division.teams.count
  end
end
