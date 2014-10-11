require 'httparty'
require 'logger'

class XmlStatsController
  include HTTParty
  base_uri 'erikberg.com'

  def fetch_events(date)
    date_formatted = date.time.strftime('%Y%m%d')
    response = perform_query("/events.json?date=#{date_formatted}&sport=nba")['events']
    response.each do |event|
      game = Game.create!({
        game_id: event['event_id'],
        status: event['event_status'],
        start_date_time: event['start_date_time'],
        season_type: event['season_type']
      })
      game.away_team = NbaTeam.find_by(team_id: 
        event['away_team']['team_id'])
      game.home_team = NbaTeam.find_by(team_id: 
        event['home_team']['team_id'])
    end
  end

  def update_rosters
    NbaTeam.all.each { |team| fetch_roster(team) }
  end

  def fetch_roster(team)
    Rails.logger.info "Updating #{team.team_id}"
    response = perform_query("/nba/roster/#{team.team_id}.json")['players']
    response.each do |slot|
      player = find_or_create(slot)
      team.players << player
    end
  end

  def fetch_teams
    response = perform_query('/nba/teams.json')
    response.each do |team|
      NbaTeam.create!({
        team_id: team['team_id'],
        abbreviation: team['abbreviation'],
        name: team['full_name'],
        conference: team['conference'],
        division: team['division'],
        site_name: team['site_name'],
        city: team['city'],
        state: team['state']
        })
    end

  end

  def fetchs_games
  end

  def fetch_boxscores
  end

  def find_or_create(params)
    Player.find_by(name: params['display_name'], 
      birthdate: params['birthdate']) ||
    Player.create!({
        name: params['display_name'],
        height_cm: params['height_cm'],
        height_formatted: params['height_formatted'],
        weight_lb: params['weight_lb'],
        weight_kg: params['weight_kg'],
        position: params['position'],
        number: params['uniform_number'],
        birthdate: params['birthdate'],
        birthplace: params['birthplace']
        })
  end

  def perform_query(path)
    response = get(path)
    return response if response.code < 400
    sleep 15
    perform_query(path)
  end

  def get(path)
    self.class.get(path, headers: {
      'User-Agent' => Rails.application.secrets.name_robot,
      'Authorization' => 'Bearer '+ Rails.application.secrets.api_key
      })
  end

end