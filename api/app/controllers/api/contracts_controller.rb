class Api::ContractsController < ApplicationController
  respond_to :json
  before_action :set_contract, only: [:destroy, :show]
  before_action :check_user_owns_contract, only: [:destroy]

  def index
    coalesce_find_requests_response(Contract)
  end

  def show
    respond_with @contract, status: 200
  end

  def destroy
    waiv = ContractWaiv.new(@contract)
    if waiv.waiv
      render json: { message: "Okay!" }, status: 200
    else
      render json: waiv.errors, status: 422
    end
  end

 private
  def set_contract
    @contract = Contract.find_by(neo_id: params[:id])
    render json: { error: "There's not such contract" }, status: 404 unless @contract
  end

  def check_user_owns_contract
    if @contract.team.user != @user
      render json: { error: "You can't waive a contract that don't belong to your team"}, status: 403
    end
  end

end