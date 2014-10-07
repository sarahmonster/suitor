class User::ConfirmationsController < Devise::ConfirmationsController

  private

    def after_confirmation_path_for(resource_name, resource)
      flash[:notice] = 'Thanks for confirming your email. You’re all set!'
      if current_user.nil?
        login_path
      else
        dashboard_path
      end
    end
end
