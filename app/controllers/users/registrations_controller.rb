class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
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

    def configure_permitted_parameters
      # Add user settings as allowed params for editing
      [:sign_up, :account_update].each do |c|
        devise_parameter_sanitizer.for(c).concat [:name, :followup_offset, :application_goal]
      end
    end
end
