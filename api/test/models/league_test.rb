require 'test_helper'

class LeagueTest < ActiveSupport::TestCase
  test "name length" do
    league = League.new
    assert_equal false, league.valid?
    league.name = "a"
    assert_equal false, league.valid?
    league.name = "aaa"
    assert_equal false, league.valid?
    league.name = "aaaaa"
    assert_equal true, league.valid?
    league.name = "El Señor de los Anillos"
    assert_equal true, league.valid?
    league.name += ": Las dos Torres"
    assert_equal false, league.valid?
  end
end
