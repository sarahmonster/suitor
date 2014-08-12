class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :lockable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.photo = auth.info.image

      # Automatically confirm this user's email since they're using it with
      # Facebook.
      user.confirm! unless user.confirmed?
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] and session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def set_default_role
    self.role ||= :user
  end

  def update_tracked_fields!(request)
    super(request) unless admin?
  end
end
