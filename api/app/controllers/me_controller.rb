class MeController < ApplicationController
  respond_to :json
  
  def whoiam
    respond_with @user, status: 200
  end
end