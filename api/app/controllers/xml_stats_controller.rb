require 'httparty'
require 'logger'

class XmlStatsController
  include HTTParty
  base_uri 'https://erikberg.com'


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
    range_operation(start_date, end_date) { |date| fetch_games(date) }
  end

  def get_boxscores_since(start_date, end_date=1.day.ago)
    range_operation(start_date, end_date) { |date| get_boxscores(date.to_datetime) }
  end

  def range_operation(start_date, end_date)
    range_dates = (start_date.to_date..end_date.to_date)
    range_dates.each { |date| yield(date) }
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
      update_stats_of(game)
    end
  end

  def update_stats_of(game)
    begin
      tx = Neo4j::Transaction.new
      game.status = 'completed' 
      boxscores = fetch_boxscores(game)
      game.boxscores = boxscores[:boxscores]
      game.away_score = boxscores[:away_score]
      game.home_score = boxscores[:home_score]
      game.save
    rescue StandardError => e
      Rails.logger.error e.message
      tx.failure
      return false
    ensure
      tx.close
    end
  end

  def fetch_boxscores(game)
    stadistics = Hash.new
    response = perform_query("/nba/boxscore/#{game.game_id}.json")
    stadistics[:away_score] = response['away_totals']['points']
    stadistics[:home_score] = response['home_totals']['points']
    stadistics[:boxscores] = []

    create_stadistics_of('away', response, stadistics, game)
    create_stadistics_of('home', response, stadistics, game)
    

    stadistics
  end

  def create_stadistics_of (side, response, stadistics, game)
     response["#{side}_stats"].each do |stat|
      player = find_player_by_name_for(stat)
      raise_search_error(stat, game) unless player
      boxscore = create_boxscore(stat, player)
      boxscore.side = side
      boxscore.save
      stadistics[:boxscores] << boxscore
      add_score(player, boxscore) unless player.fantastic_teams.empty?
    end
  end

  def find_player_by_name_for(stat)
    nodeset = Player.as(:p).where(name: stat['display_name'])
    return nodeset.first if nodeset.count == 1
    nodeset = nodeset.real_team.where(abbreviation: stat['team_abbreviation']).pluck(:p)
    return nodeset.first if nodeset.count == 1
    return false
  end

  def add_score(player, boxscore)
    player.fantastic_teams.each do |team| 
      team.score = team.score + boxscore.final_score
    end 
  end

  def raise_search_error(stat, game)
    raise "Player #{stat['display_name']} don't found for #{game.game_id}"
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
      boxscore.player = player
      boxscore
  end

  def find_or_create(params)
    Player.find_by(name: params['display_name'], 
      birthplace: params['birthplace']) || register_player(params)
   
  end

  def register_player (params)
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
    return [] if response.code == 404
    if response.code == 429
      dif = response.headers['xmlstats-api-reset'].to_i - Time.now.strftime('%s').to_i
      Rails.logger.error "Sleeping for #{dif}"
      sleep dif
    end
    raise "Access token has expired" if response.code == 403
    perform_query(path)
  end

  def get(path)
    self.class.get(path, headers: headers)
  end

  def headers
    {
      'User-Agent' => Rails.application.secrets.name_robot,
      'Authorization' => 'Bearer '+ Rails.application.secrets.api_key
    }
  end

end