class Users::InvitationsController < Devise::InvitationsController
  before_filter :require_admin, only: [:new, :remove, :destroy]
end
