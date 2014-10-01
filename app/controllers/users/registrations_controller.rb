class Users::RegistrationsController < Devise::RegistrationsController

  protected

    def after_inactive_sign_up_path_for(resource)
      home_path#(resource)
    end

    def after_sign_up_path_for(resource)
      home_path#(resource)
    end
end
