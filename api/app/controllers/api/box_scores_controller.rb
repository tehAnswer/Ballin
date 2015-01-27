class Api::BoxScoresController < ApplicationController
  respond_to :json

  # GET /api/boxscores?ids=...
  def index
    box_scores = []
    params[:ids].each do |id|
      box_score = BoxScore.find_by(neo_id: id)
      box_scores << box_score if box_score
    end if params[:ids]
    render json: box_scores
  end

  # GET /api/boxscores/1
  def show
  end

end