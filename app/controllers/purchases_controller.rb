class PurchasesController < ApplicationController
  before_action :set_purchase, except: %i[index create]

  # GET /purchases
  def index
    @purchases = current_user.purchases
  end

  # GET /purchases/{id}
  def show; end

  # POST /purchases
  def create
    @purchase = Purchase.new(purchase_params.with_defaults(user_id: current_user.id))
    if @purchase.save
      render @purchase, status: :created
    else
      render json: { errors: @purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /purchases
  def update
    @purchase.user_purchases.destroy_all

    if @purchase.update(purchase_params)
      render @purchase, status: :ok
    else
      render json: { errors: @purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /purchases
  def destroy
    if @purchase.destroy
      render json: { success: true }, status: :ok
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
    user_purchases_params

    params.permit(:description, :emoji, :name, :purchased_at, :currency,
                                     user_purchases_attributes: %i[user_id amount])
  end

  def user_purchases_params
    return unless params[:user_purchases_attributes].present?

    params[:user_purchases_attributes].each do |attrs|
      attrs[:user_phone].present? ? attrs[:user_id] = User.find_by(phone: attrs[:user_phone]).id : next
    end
  end
end
