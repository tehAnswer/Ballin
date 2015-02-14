class Api::DivisionsController < ApplicationController
  respond_to :json
  
  # GET /api/divisions?ids=...
  def index
    coalesce_find_requests_response(Division)
  end
end