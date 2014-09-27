class JobApplicationPolicy
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

  pattr_initialize :user, :job_application

  def initialize(user, job_application)
    @user = user
    @interview = job_application

    [:create, :edit, :update, :show, :destroy].each do |m|
      self.class.send(:define_method, (m.to_s + '?').to_sym) do
        @user and (@user.admin? or @user.id == @job_application.user.id)
      end
    end
  end

  def new?
    @user
  end
end
