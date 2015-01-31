class Api::FantasticTeamsController < ApplicationController

  respond_to :json

  def show
  end

  def create
    if @user.team.nil?
      fantastic_team = TeamCreation.create(@division, fantastic_team_params)
      respond_with(fantastic_team)
    else
      render json: { error: "Users can only have one team."}, status: 422
  end


   

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_division
      @division = Division.find_by(neo_id: fantastic_team_params[:division_id])
      render json: { error: "There isn't such division." }, status: 404 if @division.nil?
    end

    def fantastic_team_params
      params.require(:fantastic_team).permit(:name, :hood, :headline, :abbreviation, :division_id)
    end


end