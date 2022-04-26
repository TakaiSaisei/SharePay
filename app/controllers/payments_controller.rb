class PaymentsController < ApplicationController
  # GET /payments
  def index
    @payments = current_user.payments
  end

  # POST /payments
  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      render json: @payment, status: :created
    else
      render json: { errors: @payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :currency, :receiver_id).with_defaults(sender_id: current_user.id)
  end
end
