class ApplicationController < ActionController::Base
    helper_method :current_user
    def current_user
        debugger
        @user.session_token
        session[:session_token]
    end
end