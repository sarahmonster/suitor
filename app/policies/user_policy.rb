class UserPolicy
  pattr_initialize :active_user, :user

  def initialize(active_user, user)
    @active_user = active_user
    @user = user

    [:edit, :update, :show, :destroy].each do |m|
      self.class.send(:define_method, (m.to_s + '?').to_sym) do
        @active_user and (@active_user.admin? or
                          @active_user.id == @user.id)
      end
    end
  end
end
