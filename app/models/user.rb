class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :lockable, :registerable, :recoverable, :rememberable, :trackable, :validatable#, :omniauthable
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def update_tracked_fields!(request)
    super(request) unless self.role.admin?
  end
end