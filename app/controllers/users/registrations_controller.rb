class Users::RegistrationsController < Devise::RegistrationsController
  before_action :require_invite, only: [:new, :create]

  def new
    super
  end

  protected

    def after_inactive_sign_up_path_for(resource)
      home_path#(resource)
    end

    def after_sign_up_path_for(resource)
      home_path#(resource)
    end
end
