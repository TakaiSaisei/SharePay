class UsersController < ApplicationController
  before_action :set_user, except: %i[index create]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{phone}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /users/{phone}
  def update
    if @user.update(user_params)
      render status: :no_content
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/{phone}
  def destroy
    if @user.destroy
      render status: :no_content
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by!(phone: params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.require(:user).permit(:name, :phone)
  end
end
