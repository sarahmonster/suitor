class Users::ConfirmationsController < Devise::ConfirmationsController

  private

    def after_confirmation_path_for(resource_name, resource)
      flash[:notice] = 'Your email has been confirmed. Please log-_in!'
      new_user_session_path
    end
end
