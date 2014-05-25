class Posting < ActiveRecord::Base
	validates :title, presence: true,
                    length: { minimum: 5 }
  has_one :job_application, dependent: :destroy
  has_many :interviews, dependent: :destroy

  default_scope -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }

  def applied?
    job_application and job_application.id and job_application.date_sent
  end

  def followup_needed?
    job_application.date_sent.advance(:days => 14) < Date.current
  end

  def actionable
    if !interviews.empty? and !interviews.upcoming.empty?
      "interview-scheduled"
    elsif !interviews.empty? and interviews.upcoming.empty?
      "interview-completed"
    elsif applied? and followup_needed?
      "action-required"
    elsif !applied?
      "action-required"
    else
      ""
    end
  end
end
