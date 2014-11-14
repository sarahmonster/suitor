class OfferPolicy
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

  pattr_initialize :user, :offer

  def initialize(user, offer)
    @user = user
    @offer = offer

    [:create, :edit, :update, :show, :destroy].each do |m|
      self.class.send(:define_method, (m.to_s + '?').to_sym) do
        @user and (@user.admin? or (@offer.user and @user.id == @offer.user.id))
      end
    end
  end

  def new?
    @user
  end
end
