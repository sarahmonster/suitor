class ApplicationController < ActionController::Base
  include Pundit

  helper :date

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def require_admin
      unless current_user and current_user.admin?
        redirect_to root_path
      end
    end

    def require_login
      unless current_user
        redirect_to new_user_session_path
      end
    end
end
