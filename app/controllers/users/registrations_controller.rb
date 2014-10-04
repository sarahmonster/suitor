class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :redirect_if_in_production

  protected

    def after_inactive_sign_up_path_for(resource)
      home_path
    end

    def after_sign_up_path_for(resource)
      home_path
    end

    def redirect_if_in_production
      redirect_to root_path if Rails.env.production?
    end
end
