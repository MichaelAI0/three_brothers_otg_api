class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request

  private 
  def authenticate_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    begin
      decoded_token = jwt_decode(header)
      @current_user = User.find(decoded_token[:user_id])
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end