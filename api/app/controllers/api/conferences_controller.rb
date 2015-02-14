class Api::ConferencesController < ApplicationController
  respond_to :json
  
  # GET /api/conferences?ids=...
  def index
    coalesce_find_requests_response(Conference)
  end
end