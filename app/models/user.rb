class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :lockable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :postings, dependent: :destroy
  has_many :job_applications, through: :postings

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

  def activity_start_date
    job_applications.order('date_sent ASC').limit(1).first.date_sent
  end

  def total_applications
    job_applications.count
  end

  def applications_per_week
     ((Time.now - activity_start_date.to_datetime).to_i / (60 * 60 * 24 * 7)).to_f / total_applications.to_f
  end

  def update_tracked_fields!(request)
    super(request) unless admin?
  end
end
