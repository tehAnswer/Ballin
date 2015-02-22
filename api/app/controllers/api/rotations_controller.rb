class Api::RotationsController < ApplicationController
  before_action :set_rotation, only: [:show, :update]
  after_action :check_user_owns_team, only: [:set_rotation]
  respond_to :json

  def show
    respond_with @rotation
  end

  def update
    update = RotationUpdate.new(@rotation)
    rotation_updated = update.update(rotation_params)
    if update
      respond_with update, status: 200
    else 
      render json: update.errors, status: 422
    end
  end

 private
  def set_rotation
    @rotation = Rotation.find_by(neo_id: params[:id])
    render json: { error: "There isnt such rotation"} unless @rotation, status: 422
  end

  def check_user_owns_team
    if @rotation.team.user != @user
      render json: { error: "You can't see or modify one rotation that don't belong to your team"}, status: 403
    end
  end

  def rotation_params
    params.require(:rotation).permit(:C, :PF, :SF, :SG, :PG)
  end
end 