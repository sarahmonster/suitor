class DashboardController < ApplicationController
  def index
    @postings = Posting.all
    @postings_with_upcoming_interviews = Posting.interview_scheduled
  end
end
