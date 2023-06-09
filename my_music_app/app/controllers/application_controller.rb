class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?
    skip_before_action :verify_authenticity_token
    #CHR(R)LLL

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!current_user
    end

    def login!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout!
        current_user.reset_session_token! if logged_in?
        @current_user = nil
        session[:session_token] = nil
    end
end
