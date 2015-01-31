class Api::BoxScoresController < ApplicationController
  before_action :set_boxscore, only: [:show]
  respond_to :json


  # GET /api/box_scores?ids=...
  def index
    box_scores = []
    params[:ids].each do |id|
      box_score = BoxScore.find_by(neo_id: id)
      box_scores << box_score if box_score
    end if params[:ids]
    render json: box_scores
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