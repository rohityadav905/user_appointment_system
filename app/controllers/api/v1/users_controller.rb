class Api::V1::UsersController < Api::V1::ApiController
  before_action :authenticate_user, except: [:signin, :signup]
  
  # user signup
  def signup
	  user = User.new(user_params)
	  if user.save
	    token = user.generate_auth_token!
	    sign_in :user, user
	    render json: {user: user, token: token}
	  else
	    render json: {error: user.errors.full_messages[0] },status: 400
	  end
    
  end

  # user login
  def signin
    user = User.find_by(email: params[:user][:email])
    if user.present? and user.valid_password? params[:user][:password]
      token = user.generate_auth_token!
      sign_in :user, user
      render json: {user: user, token: token}
    else
      render json: { error: 'Incorrect email or password' }, status: 400
    end
  end

  # user signout
  def signout
    token = Token.find_by(token: access_token)
    if token.present?
      token.destroy
      sign_out(:user)
      render json: {success: "Successfully logged out"},status: 200
    else
      render json: {error: 'Unauthorized'}, status: 401
    end
  end


  private
	  def user_params
	    params.require(:user).permit(:name ,:role,:email, :first_name, :last_name, :password, :password_confirmation)
	  end
end
