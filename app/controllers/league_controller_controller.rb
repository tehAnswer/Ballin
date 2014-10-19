class LeagueControllerController < ApplicationController

  # POST /leagues
  # POST /leagues.json
  def create
    @league = LeagueCreation.new (league_params)

    if @league.save
      render json: @league, location: @league, root: true
    else
      render json: @league.errors
    end
  end

end
