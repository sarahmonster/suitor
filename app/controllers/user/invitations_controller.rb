class User::InvitationsController < Devise::InvitationsController
  before_filter :configure_permitted_parameters
  before_filter :require_admin, only: [:new, :remove, :destroy]

  def invited_by
    current_user
  end

  protected

    def configure_permitted_parameters
      # Add user settings as allowed params for invites.
      [:accept_invitation, :invite].each do |c|
        devise_parameter_sanitizer.for(c).concat [:name]
      end
    end
end
