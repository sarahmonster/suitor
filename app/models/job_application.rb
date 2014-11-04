class JobApplication < ActiveRecord::Base
  belongs_to :posting
  has_one :user, through: :posting

  after_initialize :set_applied_date
  before_update :dont_change_time_for_same_date
  before_validation :ensure_datetime_not_date

  validates :date_sent, presence: true
  validates :posting, presence: true

  private
    def dont_change_time_for_same_date
      if self.date_sent_changed? and self.date_sent and
         self.date_sent.to_date == self.date_sent_was.to_date
        self.date_sent = self.date_sent_was
      end
    end

    def ensure_datetime_not_date
      self.date_sent.to_datetime
    end

    def set_applied_date
      self.date_sent = DateTime.now if self.date_sent.blank?
    end
end
