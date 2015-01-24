class LeagueCreation

  def self.create(params)
   begin
      tx = Neo4j::Transaction.new
      league = League.new(params)
      return league unless league.save

      eastern_conference = Conference.create!(name: 'East')
      western_conference = Conference.create!(name: 'West')

      atlantic_division = Division.create!(name: 'Atlantic')
      central_division = Division.create!(name: 'Central')
      southeast_division = Division.create!(name: 'Southeast')
      northwest_division = Division.create!(name: 'Northwest')
      pacific_division = Division.create!(name: 'Pacific')
      southwest_division = Division.create!(name: 'Southwest')

      atlantic_division.conference = eastern_conference
      central_division.conference = eastern_conference
      southeast_division.conference = eastern_conference

      northwest_division.conference = western_conference
      pacific_division.conference = western_conference
      southwest_division.conference = western_conference

      league.conferences << eastern_conference
      league.conferences << western_conference
      return league
  rescue StandardError => e
    Rails.logger.error e.message
    return false
  ensure
    tx.close
  end
 end
end