class ApplicationController < ActionController::Base
  protected
    def ensure_authenticated_user
      head :unauthorized unless current_user
    end

    def current_user
      api_key = ApiKey.active.where(access_token: token).first
      if api_key
        return api_key.user
      else
        return nil
      end
    end

    def token
      bearer = request.headers["HTTP_AUTHORIZATION"]

      bearer ||= request.headers["rack.session"].try(:[], 'Authorization')

      if bearer.present?
        bearer.split.last
      else
        nil
      end
    end







  # protect_from_forgery with: :exception
  # helper_method :signed_in?, :current_user

  # def sign_in user
  #   remember_token = User.new_remember_token
  #   cookies.permanent[:remember_token] = remember_token
  #   user.update_attribute(:remember_token, User.encrypt(remember_token))
  #   self.current_user = user
  # end

  # def signed_in?
  #   !current_user.nil?
  # end

  # def current_user=(user)
  #   @current_user = user
  # end

  # def current_user
  #   remember_token = User.encrypt(cookies[:remember_token])
  #   @current_user ||= User.find_by_remember_token(remember_token)
  # end

  # def sign_out
  #   self.current_user = nil
  #   cookies.delete(:remember_token)
  # end
end
