class Api::FantasticTeamsController < ApplicationController

  def show
  end

  def create
    @fantastic_team = TeamCreation.create(@division, fantastic_team_params)
  end


   

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_division
      @division = Division.find_by(neo_id: params[:division_id])
      render json: "There isn't such division.", status: 400 if @division.nil?
    end

    def fantastic_team_params
      params.require(:fantastic_team).permit(:name, :hood, :headline, :abbreviation)
    end


end