module Authenticable
  extend ActiveSupport::Concern

  included do
    include JsonWebToken
    before_action :authenticate_user
    helper_method :current_user
  end

  private

  def authenticate_user
    render status: :unauthorized unless authorized?
  end

  def authorized?
    (token = decoded_token) && (@current_user = User.find_by(id: token['user_id']))
  end

  def current_user
    @current_user
  end
end
