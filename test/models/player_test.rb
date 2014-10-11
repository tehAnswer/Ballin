require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test 'coherent attributes' do
     player = Player.create({name: 'Nerlens', height_cm: 210.1, height_formatted: "5'1\""})
     assert_equal false, player.errors.empty?

     player.position = 'C'
     player.weight_kg = 98.1
     player.weight_lb = 200
     player.number = '4'
     player.birthplace = 'Kansas'
     player.birthdate = '09/02/2010'

     assert_equal true, player.valid?
  end

  test 'save an empty player' do
    player = Player.new
    assert_equal false, player.save 
  end




end