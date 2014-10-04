class Users::InvitationsController < Devise::InvitationsController
  before_filter :configure_permitted_parameters
  before_filter :require_admin, only: [:new, :remove, :destroy]

  protected

    def configure_permitted_parameters
      # Add user settings as allowed params for invites.
      [:accept_invitation, :invite].each do |c|
        devise_parameter_sanitizer.for(c).concat [:name]
      end
    end
end
