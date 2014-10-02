class Users::RegistrationsController < Devise::RegistrationsController
  before_action :redirect_to_root

  protected

    def after_inactive_sign_up_path_for(resource)
      home_path#(resource)
    end

    def after_sign_up_path_for(resource)
      home_path#(resource)
    end

    def redirect_to_root
      redirect_to root_path
    end
end
