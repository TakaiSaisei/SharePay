class DebtsController < ApplicationController
  # GET /debts
  def index
    @debts = current_user.debts
    render json: @debts, status: :ok
  end
end
