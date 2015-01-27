ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase


  def parse(body)
    JSON.parse(body, symbolize_names: true)
  end
  
  def add_teams
		[ NbaTeam.create!({team_id: 'philadephia-76-ers',
        abbreviation: 'PHI',
        name: 'Philadelphia 76ers',
        conference: 'East',
        division: 'Atlantic',
        site_name: 'Wells Fargo',
        city: 'Philadelphia',
        state: 'Pennsylvannia'}),

    NbaTeam.create!({team_id: 'los-angeles-lakers',
        abbreviation: 'LAL',
        name: 'Los Angeles Lakers',
        conference: 'West',
        division: 'South',
        site_name: 'Stapples Center',
        city: 'Los Angeles',
        state: 'California'})
  ]
  end

  def add_players
    [Player.create!({
      name: 'Kobe Bryant',
      height_cm: 200,
      height_formatted: "6' 1\"",
      weight_lb: 100,
      weight_kg: 50,
      position: 'SG',
      number: '24',
      birthplace: 'Philly',
      birthdate: Date.new,
      }), 

    Player.create!({
      name: 'Allen Iverson',
      height_cm: 200,
      height_formatted: "6' 1\"",
      weight_lb: 100,
      weight_kg: 50,
      position: 'PG',
      number: '3',
      birthplace: 'Philly',
      birthdate: Date.new,
      })]
  end

end
