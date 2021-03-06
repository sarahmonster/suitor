class PostingPolicy
  class Scope
    pattr_initialize :user, :postings

    def initialize(user, postings)
      @user = user
      @postings = postings
    end

    def resolve
      postings.where(user_id: user.id)
    end
  end

  pattr_initialize :user, :posting

  def initialize(user, posting)
    @user = user
    @posting = posting

    [:archivetoggle, :create, :edit, :update, :show, :destroy].each do |m|
      self.class.send(:define_method, (m.to_s + '?').to_sym) do
        @user and (@user.admin? or (@posting.user and @user.id == @posting.user.id))
      end
    end
  end

  def new?
    @user
  end
end
