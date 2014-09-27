class InterviewPolicy
  class Scope
    pattr_initialize :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.joins(:posting).where(postings: {user_id: @user.id})
    end
  end

  pattr_initialize :user, :interview

  def initialize(user, interview)
    @user = user
    @interview = interview

    [:create, :edit, :update, :show, :destroy].each do |m|
      self.class.send(:define_method, (m.to_s + '?').to_sym) do
        @user and (@user.admin? or @user.id == @interview.user.id)
      end
    end
  end

  def new?
    @user
  end
end
