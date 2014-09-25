class DashboardController < ApplicationController
  def index
    @postings = Posting.all
    @postings_with_upcoming_interviews = Posting.interview_scheduled
    @postings_needing_followup = Posting.without_followup
    @postings_needing_application = Posting.havent_applied
    @postings_with_upcoming_deadlines = Posting.havent_applied.deadline_approaching
  end
end
