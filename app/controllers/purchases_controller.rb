class PurchasesController < ApplicationController
  before_action :set_purchase, except: %i[index create]

  # GET /purchases
  def index
    @purchases = Purchase.all
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

  # PUT /purchases/{id}
  def update
    if @purchase.update(purchase_params)
      render status: :no_content
    else
      render json: { errors: @purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /purchases/{id}
  def destroy
    if @purchase.destroy
      render status: :no_content
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
    params.require(:purchase).permit(:description, :emoji, :name, :user_id)
  end
end
