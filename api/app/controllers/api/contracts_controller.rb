class Api::ContractsController < ApplicationController

  def index
    coalesce_find_requests_response(Contract)
  end
end