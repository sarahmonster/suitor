class JobApplication < ActiveRecord::Base
  belongs_to :posting
  has_one :user, through: :posting
  after_initialize :set_applied_date

  validates :date_sent, presence: true
  validates :posting, presence: true

  private
    def set_applied_date
      self.date_sent = Date.today if self.date_sent.blank?
    end
end
