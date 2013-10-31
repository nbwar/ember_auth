class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

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
end
