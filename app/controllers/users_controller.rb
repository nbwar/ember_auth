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
      render json: {errors: user.errors.message}, status: 422
    else
      render json: user.session_api_key, status: 201
    end
  end



private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end


  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     sign_in @user
  #     flash[:notice] = "Welcome to MealPlanner!"
  #     redirect_to root_path
  #   else
  #     @errors = @user.errors.full_messages
  #     render :new
  #   end
  # end

  # def show
  # end



end
