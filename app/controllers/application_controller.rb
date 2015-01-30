class ApplicationController < ActionController::Base
  include Pundit
  before_filter :get_user_data

  helper :date

  # Get the current user ID for Google Analytics
  def get_user_data
    if current_user
      @userid = current_user.id
    end
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    # Overwriting the sign_out redirect path method
    def after_sign_out_path_for(resource_or_scope)
      home_path
    end

    def require_admin
      unless current_user and current_user.admin?
        redirect_to root_path
      end
    end

    def require_invite
      unless current_user and current_user.invited_to_sign_up?
        redirect_to home_path
      end
    end

    def require_login
      unless current_user
        redirect_to login_path
      end
    end
end
