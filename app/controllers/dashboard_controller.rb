class DashboardController < ApplicationController
  before_action :require_login
  
  def index
    @postings = Posting.all
    @postings_with_upcoming_interviews = Posting.interview_scheduled
    @postings_needing_followup = Posting.without_followup
    @postings_needing_application = Posting.havent_applied
    @postings_with_upcoming_deadlines = Posting.havent_applied.deadline_approaching
    @postings_applied_for = Posting.total_applied
    @postings_archived = Posting.archived
    @postings_with_interviews = Posting.with_interviews
    @postings_applied_this_week = Posting.applied_this_week
    @date_started = current_user.activity_start_date
  end
end
