require 'test_helper'

class ContractTest < ActiveSupport::TestCase
  test "minimum salary" do
    # This in China or Spain may not pass.
    contract = Contract.create(salary: 1)
    assert_equal false, contract.valid?
    contract.salary = 500_000
    assert_equal true, contract.valid?
  end
end
