class Api::BoxScoresController < ApplicationController
  before_action :set_boxscore, only: [:show]
  respond_to :json


  # GET /api/box_scores?ids=...
  def index
    coalesce_find_requests_response(BoxScore)
  end

  # GET /api/box_scores/1
  def show
    respond_with @box_score, status: 200
  end

  private
    def set_boxscore
      @box_score = BoxScore.find_by(neo_id: params[:id])
      render json: { error: "There's not such boxscore" }, status: 404 unless @box_score
    end

end