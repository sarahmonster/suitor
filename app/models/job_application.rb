class JobApplication < ActiveRecord::Base
  belongs_to :posting
  has_one :user, through: :posting

  after_initialize :set_applied_date
  before_validation :ensure_datetime_not_date

  validates :date_sent, presence: true
  validates :posting, presence: true

  private
    def set_applied_date
      self.date_sent = DateTime.now if self.date_sent.blank?
    end

    def ensure_datetime_not_date
      self.date_sent.to_datetime
    end
end
