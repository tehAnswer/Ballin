class XmlStatsController < ApplicationController

  def fetch_events(date)
    date_formatted = date.time.strftime('%Y%m%d')
  end

  def fetch_rosters
  end

  def fetch_teams
  end

  def fetchs_games
  end

  def fetch_boxscores
  end

end