class DashboardController < ApplicationController
  def index
    @postings = Posting.all
    @postings_with_upcoming_interviews = Posting.interview_scheduled
    @postings_needing_followup = Posting.without_followup
    @postings_needing_application = Posting.havent_applied
  end
end
