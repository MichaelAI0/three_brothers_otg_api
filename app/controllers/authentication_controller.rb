class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  # Post /auth/login

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = jwt_encode(user_id: @user.id)
      render json: {token: token, user: @user}, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
