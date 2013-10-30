class SessionsController < ApplicationController

  def create
    user = User.where("username = ? OR email = ?", params[:user
      _or_email], params[:username_or_email]).first
    if user && user.authenticate(params[:password])
      render json: user.session_api_key, status 201
    else
      render json: {}, status: 401
    end

  end






  # def new
  # end

  # def create
  #   user = User.find_by_email(user_email)
  #   if user && user.authenticate(user_password)
  #     sign_in user
  #     flash[:notice] = "Successfully logged in"
  #     redirect_to root_url
  #   else
  #     @errors = ["Invalid email/password combination."]
  #     render :new
  #   end
  # end

  # def destroy
  #   sign_out
  #   flash[:notice] = "You Hae successfully Logged Out"
  #   redirect_to root_url
  # end

  # private
  #   def user_email
  #     params[:session][:email].downcase
  #   end

  #   def user_password
  #     params[:session][:password]
    # end
end
