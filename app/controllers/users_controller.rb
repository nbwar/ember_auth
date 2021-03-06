class UsersController < ApplicationController
  before_filter :ensure_authenticated_user, only: [:index]
  # respond_to :json

  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end

  def create
    user = User.create(user_params)
    if user.new_record?
      render json: {errors: user.errors}, status: 422
    else
      render json: user.session_api_key, status: 201
    end
  end

private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

end
