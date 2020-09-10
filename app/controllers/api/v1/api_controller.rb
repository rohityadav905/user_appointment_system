class Api::V1::ApiController < ActionController::Base
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  # check user is authenticated or not
  def authenticate_user
    unauthorized unless current_user
  end

 	# define current user after login
  def current_user
    if access_token.present?
      @current_user ||= Token.find_by_token(access_token)&.user
    end
  end

  # send mssage if user is not authorized
  def unauthorized
    render json: {error: 'Unauthorized'}, status: 401
  end

  def not_found
    render json: {error: 'not found'}, status: 404
  end


  private
	  def access_token
	   return request.headers[:Authorization]
	  end
end