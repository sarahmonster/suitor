class Interview < ActiveRecord::Base
  belongs_to :posting
  validates :posting, presence: true

  # Concatenate date and time
  include DateTimeAttribute
  date_time_attribute :datetime
end
