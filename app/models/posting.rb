class Posting < ActiveRecord::Base
  VALID_FILTER_SCOPES = [:applied, :archived, :interview_completed, :interview_scheduled]

  validates :user, presence: true
  validates :title, presence: true, length: { minimum: 5 }
  validates :hiring_organization, presence: true, length: { minimum: 5 }

  belongs_to :user
  has_one :job_application, dependent: :destroy
  has_many :interviews, dependent: :destroy
  enum role: [:user, :admin]

  # Define scopes for easier access
  default_scope -> {
    where(archived: false)
  }
  scope :applied, -> {
    joins(:job_application).where('job_applications.date_sent IS NOT NULL')
  }
  scope :total_applied, -> {
    unscoped.joins(:job_application).where('job_applications.date_sent IS NOT NULL')
  }
  scope :applied_this_week, -> {
    joins(:job_application).where('job_applications.date_sent >= ?', Date.today.beginning_of_week)
  }
  scope :havent_applied, -> {
    where("NOT EXISTS (SELECT null FROM job_applications where job_applications.posting_id = postings.id)")
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
  scope :with_interviews, -> {
    where("EXISTS (SELECT null FROM interviews where interviews.posting_id = postings.id)")
  }
  scope :no_interviews, -> {
    where("NOT EXISTS (SELECT null FROM interviews where interviews.posting_id = postings.id)")
  }
  scope :with_deadline, -> {
    where('deadline IS NOT NULL')
  }
  scope :deadline_approaching, -> {
    where('deadline > ?', Time.now)
  }
  scope :deadline_passed, -> {
    where('deadline < ?', Time.now)
  }
  scope :with_followup, -> {
     joins(:job_application).where('followup IS NOT NULL')
  }
  scope :without_followup, -> (followup_offset) {
     joins(:job_application).where('followup IS NULL AND job_applications.date_sent < ?', Date.current.advance(days: -followup_offset))
  }

  def self.valid_scope?(scope_name)
    if scope_name
      VALID_FILTER_SCOPES.include? scope_name.to_sym
    end
  end

  # Sort all posts by "importance", as defined by methods below
  def self.sorted_by_importance(followup_offset)
    postings = interview_scheduled_or_deadline_approaching +
               unapplied_or_interview_completed +
               without_followup(followup_offset).where('deadline IS NULL').no_interviews.order('job_applications.date_sent DESC') +
               recently_applied_or_followed_up_or_deadline_passed

    # Squash duplicates.
    postings.uniq { |p| p.id }
  end

  # Find all postingss with an interview scheduled, or with an application due for a deadline
  # and sort by their key dates (interview date and deadline, respectively)
  def self.interview_scheduled_or_deadline_approaching
    postings = interview_scheduled +
               havent_applied.deadline_approaching

    # We use a proxy array here because we're operating directly on
    # ActiveRecord models/objects and we can't add a property to them
    # without doing attr_accessor nonsense.
    # TODO: Make this slicker.
    key_dates = {}
    postings.each { |p|
      if p.interviews.count > 0
        key_dates[p.id] = p.interviews.upcoming.first.datetime
      else
        key_dates[p.id] = p.deadline
      end
    }

    # Squash duplicates.
    postings.uniq { |p| p.id }

    # Sort in ASC order, since these are future dates (i.e. earlier dates/deadlines come first).
    postings.sort { |p1, p2| key_dates[p1.id].to_date <=> key_dates[p2.id].to_date }
  end

  # Find all postings with an interview completed, or posts that have not been applied to,
  # and sort by their key dates (interview date and posting/updated date, respectively).
  # Ignore any posting with a deadline.
  def self.unapplied_or_interview_completed
    postings = havent_applied.where('deadline IS NULL') +
               interview_completed

    # Proxy array
    key_dates = {}
    postings.each { |p|
      if p.interviews.count > 0
        key_dates[p.id] = p.interviews.last.datetime
      elsif p.date_posted
        key_dates[p.id] = p.date_posted
      else
        key_dates[p.id] = p.updated_at
      end
    }

    # Squash duplicates.
    postings.uniq { |p| p.id }

    # Sort in DESC order, since these are past dates (i.e. later dates/deadlines come first).
    postings.sort { |p1, p2| key_dates[p2.id].to_date <=> key_dates[p1.id].to_date }
  end

  # Find all remaining postings (recently applied, followed-up, and deadline passed)
  # and sort by their key dates (applied date and follow-up, respectively).
  def self.recently_applied_or_followed_up_or_deadline_passed
    postings = deadline_passed.havent_applied.no_interviews +
               with_followup.no_interviews +
               applied.no_interviews

    # Proxy array
    key_dates = {}
    postings.each { |p|
      if p.deadline
        key_dates[p.id] = p.deadline
      elsif p.job_application.followup
        key_dates[p.id] = p.job_application.followup
      elsif p.job_application.date_sent
        key_dates[p.id] = p.job_application.date_sent
      elsif p.date_posted
        key_dates[p.id] = p.date_posted
      else
        key_dates[p.id] = p.updated_at
      end
    }

    # Squash duplicates.
    postings.uniq { |p| p.id }

    # Sort in DESC order, since these are past dates (i.e. later dates/deadlines come first).
    postings.sort { |p1, p2| key_dates[p2.id].to_date <=> key_dates[p1.id].to_date }
  end

  # Sort all posts by their application statuses
  def self.sorted_by_status
    postings = interview_scheduled.order('interviews.datetime ASC') +
               havent_applied +
               no_interviews.joins(:job_application).order('job_applications.followup ASC') +
               interview_completed

    # Squash duplicates.
    postings.uniq { |p| p.id }
  end

  # These methods allow for easier checks on certain statuses of the postings
  def action_required?
    !applied? or (applied? and followup_needed?)
  end

  def applied?
    job_application and job_application.id and job_application.date_sent
  end

  def followup_needed?
    if job_application
      job_application.date_sent.advance(:days => followup_offset) < Date.current and interviews.empty? and !job_application.followup?
    end
  end

  def interview_completed?
    !interviews.empty? and interviews.upcoming.empty?
  end

  def interview_scheduled?
    !interviews.empty? and !interviews.upcoming.empty?
  end

  def followup_offset
    user.followup_offset
  end

  def actionable
    return @actionable if @actionable

    @actionable ||=
      if interview_scheduled?
        "interview-scheduled"
      elsif interview_completed?
        "interview-completed"
      elsif followup_needed?
        "followup-needed"
      elsif !applied?
        "application-needed"
      else
        ""
      end
  end
end
