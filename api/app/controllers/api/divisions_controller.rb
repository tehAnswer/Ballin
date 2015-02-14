class Api::DivisionsController < ApplicationController
  
  # GET /api/divisions?ids=...
  def index
    coalesce_find_requests_response(Division)
  end
end