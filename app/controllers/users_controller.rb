class UsersController < ApplicationController
  before_action :set_user, except: %i[index create]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{id}
  def show
    render json: @user, status: :ok
  end

  # PUT /users/{id}
  def update
    if @user.update(user_params)
      render status: :no_content
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/{id}
  def destroy
    if @user.destroy
      render status: :no_content
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def purchases
    @user.purchases
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.require(:user).permit(:name, :phone)
  end
end
