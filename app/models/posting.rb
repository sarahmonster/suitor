class Posting < ActiveRecord::Base
	VALID_FILTER_SCOPES = [:applied, :archived, :interview_completed, :interview_scheduled]

	validates :title, presence: true,
                    length: { minimum: 5 }
  has_one :job_application, dependent: :destroy
  has_many :interviews, dependent: :destroy
	enum role: [:user, :admin]

  default_scope -> {
    where(archived: false)
  }
  scope :applied, -> {
    joins(:job_application).where('job_applications.date_sent IS NOT NULL')
  }
  scope :archived, -> {
    unscoped.where(archived: true)
  }
  scope :interview_completed, -> {
    joins(:interviews).where('interviews.datetime < ?', Time.now)
  }
  scope :interview_scheduled, -> {
    joins(:interviews).where('interviews.datetime >= ?', Time.now)
  }

  # { joins(:interviews).where('interviews.date_sent < ?', Date.current.advance(days: 14)) }

	def self.valid_scope?(scope_name)
    if scope_name
  		VALID_FILTER_SCOPES.include? scope_name.to_sym
    end
	end

  def action_required?
    !applied? or (applied? and followup_needed?)
  end

  def applied?
    job_application and job_application.id and job_application.date_sent
  end

  def followup_needed?
    job_application.date_sent.advance(days: -14) > Date.current
  end

  def interview_completed?
    !interviews.empty? and interviews.upcoming.empty?
  end

  def interview_scheduled?
    !interviews.empty? and !interviews.upcoming.empty?
  end

  def actionable
    if interview_scheduled?
      "interview-scheduled"
    elsif interview_completed?
      "interview-completed"
    elsif !applied?
      "application-needed"
    else
      ""
    end
  end
end
