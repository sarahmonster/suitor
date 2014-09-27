class UserPolicy
  pattr_initialize :active_user, :user

  def initialize(active_user, user)
    @active_user = active_user
    @user = user

    [:index, :archivetoggle, :edit, :update, :show, :destroy].each do |m|
      self.class.send(:define_method, (m.to_s + '?').to_sym) do
        @user and (@user.admin? or @user.id == @posting.user_id)
      end
    end
  end
end
