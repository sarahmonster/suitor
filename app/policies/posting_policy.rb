class PostingPolicy
  class Scope
    pattr_initialize :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  pattr_initialize :user, :posting

  def initialize(user, posting)
    @user = user
    @posting = posting

    [:archivetoggle, :create, :edit, :update, :show, :destroy].each do |m|
      self.class.send(:define_method, (m.to_s + '?').to_sym) do
        @user and (@user.admin? or @user.id == @posting.user.id)
      end
    end
  end

  def new?
    @user
  end
end
