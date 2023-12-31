class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user, only: [:show, :destroy]

  # Get /users
  def Index
    @users = User.all
    render json: @users, status: :ok
  end

  #Get /users/{username}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  # PUT /users/{username}

  def destroy 
    @user.destroy
  end

  private
  
  def user_params
    params.permit(:username, :email, :password)
  end

  def set_user
    @user = User.fin(params[:id])
  end
end
