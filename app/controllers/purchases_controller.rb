class PurchasesController < ApplicationController
  before_action :set_purchase, except: %i[index create]

  # GET /purchases
  def index
    @purchases = current_user.purchases
    render json: @purchases, status: :ok
  end

  # GET /purchases/{id}
  def show
    render json: @purchase, status: :ok
  end

  # POST /purchases
  def create
    @purchase = Purchase.new(purchase_params)
    if @purchase.save
      render json: @purchase, status: :created
    else
      render json: { errors: @purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_purchase
    @purchase = Purchase.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Purchase not found' }, status: :not_found
  end

  def purchase_params
    params[:purchase][:user_purchases_attributes].each do |attrs|
      attrs[:user_phone].present? ? attrs[:user_id] = User.find_by(phone: attrs[:user_phone]).id : next
    end

    params.require(:purchase).permit(:description, :emoji, :name, :purchased_at, user_purchases_attributes: %i[id user_id amount])
          .with_defaults(user_id: current_user.id)
  end
end
