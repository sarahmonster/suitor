class User::PasswordsController < Devise::PasswordsController

  private

    # The path used after sending reset password instructions
    def after_sending_reset_password_instructions_path_for(resource_name)
      login_path if is_navigational_format?
    end

    # Check if a reset_password_token is provided in the request
    def assert_reset_token_passed
      if params[:reset_password_token].blank?
        set_flash_message(:alert, :no_token)
        redirect_to login_path
      end
    end
end
