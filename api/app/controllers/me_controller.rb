class MeController < ApplicationController
  respond_to :json
  
  def whoiam
    respond_with @user, status: 200
  end

  def my_team
    respond_with @user.team, status: 200
  end

  def my_league
    respond_with @user.team.league, status: 200
  end
end