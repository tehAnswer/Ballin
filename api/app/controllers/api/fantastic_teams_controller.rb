class Api::FantasticTeamsController < ApplicationController
  respond_to :json
  before_action :set_division, only: [:create]
  before_action :set_fantastic_team, only: [:show]

  def index
    coalesce_find_requests_response(FantasticTeam)
  end

  def show
    respond_with @fantastic_team
  end

  def create
    if @user.team.nil?
      ft_creation = FantasticTeamCreation.new
      fantastic_team = ft_creation.create(@division, fantastic_team_params, @user)
      if fantastic_team && fantastic_team.persisted?
        respond_with fantastic_team, location: "api/fantastic_team/#{fantastic_team.neo_id}"
      else
        render json: { errors: ft_creation.errors }, status: 422
      end
    else
      render json: { error: "Users can only have one team."}, status: 422
    end
  end

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_division
      @division = Division.find_by(neo_id: fantastic_team_params[:division_id])
      render json: { error: "There isn't such division." }, status: 404 if @division.nil?
    end

    def set_fantastic_team
      @fantastic_team = FantasticTeam.find_by(neo_id: params[:id])
      render json: { error: "Not such fantastic team" }, status: 404 unless @fantastic_team
    end

    def fantastic_team_params
      params.require(:fantastic_team).permit(:name, :hood, :headline, :abbreviation, :division_id)
    end


end