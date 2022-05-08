class DebtsController < ApplicationController
  before_action :set_debt, only: %i[show]

  # GET /debts
  def index
    @debts = current_user.mine_debts.where('amount != 0.0')
  end

  # GET /debts/{id}
  def show; end

  private

  def set_debt
    @debt = Debt.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Debt not found' }, status: :not_found
  end
end
