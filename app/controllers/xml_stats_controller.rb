require 'httparty'
require 'logger'

class XmlStatsController
  include HTTParty
  base_uri 'erikberg.com'

  def fetch_games(date)
    date_formatted = date.strftime('%Y%m%d')
    response = perform_query("/events.json?date=#{date_formatted}&sport=nba")['event']
    response.each do |event|
      game = Game.create!({
        game_id: event['event_id'],
        status: event['event_status'],
        start_date_time: event['start_date_time'],
        season_type: event['season_type'],
        date_formatted: event['start_date_time'].to_date.strftime('%Y%m%d')
      })
      game.away_team = NbaTeam.find_by(team_id: 
        event['away_team']['team_id'])
      game.home_team = NbaTeam.find_by(team_id: 
        event['home_team']['team_id'])
    end
  end

  def get_scheduled_games(start_date, end_date)
    arr = (start_date.to_date..end_date.to_date)
    arr.each { |date| fetch_games(date) }
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

  def get_boxscores(day)
    date = day.strftime('%Y%m%d')
    games = Game.on_date(date)
    games.each do |game|
      return unless game.start_date_time.to_date.past?
      game.status = 'completed' 
      boxscores = fetch_boxscores(game.game_id)
      game.away_boxscores << boxscores[:away]
      game.home_boxscores <<  boxscores[:home]
      game.away_score = boxscores[:away_score]
      game.home_score = boxscores[:home_score]
    end
  end

  def fetch_boxscores(id)
    stadistics = Hash.new
    response = perform_query("/nba/boxscore/#{id}.json")
    stadistics[:away_score] = response['away_score'].sum
    stadistics[:home_score] = response['home_score'].sum
    stadistics[:away_boxscores] = []
    stadistics[:home_boxscores] = []

    response['away_stats'].each do |stat| 
      stadistics[:away_boxscores] << create_boxscore(stat)
    end

    response['home_stats'].each do |stat| 
      stadistics[:home_boxscores] << create_boxscore(stat)
    end

    stadistics
  end

  def create_boxscore(stat)
    boxscore = BoxScore.create!({
        minutes: stat['minutes'],
        points: stat['points'],
        assists: stat['assists'],
        turnovers: stat['turnovers'],
        steals: stat['steals'],
        blocks: stat['blocks'],
        ftm: stat['free_throws_made'],
        fta: stat['free_throws_attempted'],
        msa: stat['field_goals_attempted'],
        msm: stat['field_goals_made'],
        lsa: stat['three_point_field_goals_attempted'],
        lsm: stat['three_point_field_goals_made'],
        defr: stat['defensive_rebounds'],
        ofr: stat['offensive_rebounds'],
        is_started: stat['is_started'],
        faults: stat['personal_faults'],
        final_score: BoxScore.points_calculator
        })
      player = Player.find_by(display_name: stat['display_name'], 
        position: stat['position'])
      player.boxscores << boxscore

      boxscore
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
    sleep 5
    puts response
    perform_query(path)
  end

  def get(path)
    self.class.get(path, headers: {
      'User-Agent' => Rails.application.secrets.name_robot,
      'Authorization' => 'Bearer '+ Rails.application.secrets.api_key
      })
  end

end