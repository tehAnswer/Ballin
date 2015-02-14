class Api::ConferencesController < ApplicationController
  
  # GET /api/conferences?ids=...
  def index
    coalesce_find_requests_response(Conference)
  end
end