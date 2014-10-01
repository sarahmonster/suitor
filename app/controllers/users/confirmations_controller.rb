class Users::ConfirmationsController < Devise::ConfirmationsController

  private

    def after_confirmation_path_for(resource_name, resource)
      flash[:notice] = 'Thanks for confirming your email. You’re all set!'
      new_user_session_path
    end
end
