class Interview < ActiveRecord::Base
  belongs_to :posting
  has_one :user, through: :posting
  validates :posting, presence: true

  scope :upcoming, -> { where('datetime > ?', Time.now) }

  # Concatenate date and time
  include DateTimeAttribute
  date_time_attribute :datetime
end
