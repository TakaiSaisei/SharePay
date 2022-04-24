class PaymentsController < ApplicationController
  before_action :set_payment, except: %i[index create]

  # GET /payments
  def index
    @payments = current_user.payments
    render json: @payments, status: :ok
  end

  # GET /payments/{id}
  def show
    render json: @payment, status: :ok
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

  def set_payment
    @payment = Payment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Payment not found' }, status: :not_found
  end

  def payment_params
    params.require(:payment).permit(:amount, :currency, :receiver_id).with_defaults(sender_id: current_user.id)
  end
end
