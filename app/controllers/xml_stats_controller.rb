require 'httparty'
require 'logger'

class XmlStatsController
  include HTTParty
  base_uri 'https://www.erikberg.com'


  def fetch_games(date)
    date_formatted = date.to_datetime.strftime('%Y%m%d')
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
      player.real_team = team
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
    games = Game.on_date(day)
    games.each do |game|
      return unless game.start_date_time.to_date.past?
      next if game.boxscores.count > 0
      game.status = 'completed' 
      boxscores = fetch_boxscores(game)
      game.away_boxscores << boxscores[:away_boxscores]
      game.home_boxscores <<  boxscores[:home_boxscores]
      game.away_score = boxscores[:away_score]
      game.home_score = boxscores[:home_score]
      game.save
    end
  end

  def fetch_boxscores(game)
    stadistics = Hash.new
    response = perform_query("/nba/boxscore/#{game.game_id}.json")
    stadistics[:away_score] = response['away_totals']['points']
    stadistics[:home_score] = response['home_totals']['points']
    stadistics[:away_boxscores] = []
    stadistics[:home_boxscores] = []
    away_team = Game.away_team
    home_team = Game.home_team

    response['away_stats'].each do |stat|
      player = away_team.players.find_by(name: stat['display_name'])
      stadistics[:away_boxscores] << create_boxscore(stat, player)
    end

    response['home_stats'].each do |stat| 
      player = home_team.players.find_by(name: stat['display_name']) 
      stadistics[:home_boxscores] << create_boxscore(stat, player)
    end

    stadistics
  end

  def create_boxscore(stat, player)
    boxscore = BoxScore.create!({
        minutes: stat['minutes'],
        points: stat['points'],
        assists: stat['assists'],
        turnovers: stat['turnovers'],
        steals: stat['steals'],
        blocks: stat['blocks'],
        ftm: stat['free_throws_made'],
        fta: stat['free_throws_attempted'],
        fga: stat['field_goals_attempted'],
        fgm: stat['field_goals_made'],
        lsa: stat['three_point_field_goals_attempted'],
        lsm: stat['three_point_field_goals_made'],
        defr: stat['defensive_rebounds'],
        ofr: stat['offensive_rebounds'],
        is_starter: stat['is_starter'],
        faults: stat['personal_fouls']
        })
      puts "#{boxscore} #{player}"
      boxscore.player = player
      #player.boxscores << boxscore
      boxscore
  end

  def find_or_create(params)
    Player.find_by(name: params['display_name'], 
      birthplace: params['birthplace']) ||
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
    return response if response.code == 200
    sleep 5
    perform_query(path)
  end

  def get(path)
    self.class.get(path, headers: {
      'User-Agent' => Rails.application.secrets.name_robot,
      'Authorization' => 'Bearer '+ Rails.application.secrets.api_key
      })
  end

end