class DashboardController < ApplicationController
  after_action :verify_policy_scoped, only: [:index]
  before_action :require_login

  def index
    @postings = policy_scope Posting.all
    @postings_with_upcoming_interviews = policy_scope Posting.interview_scheduled
    @postings_needing_followup = policy_scope Posting.without_followup
    @postings_needing_application = policy_scope Posting.havent_applied
    @postings_with_upcoming_deadlines = policy_scope Posting.havent_applied.deadline_approaching
    @postings_applied_for = policy_scope Posting.total_applied
    @postings_archived = policy_scope Posting.archived
    @postings_with_interviews = policy_scope Posting.with_interviews
    @postings_applied_this_week = policy_scope Posting.applied_this_week
    @date_started = current_user.activity_start_date
    @applications_per_week = current_user.applications_per_week.round(1)
    @percent_difference = (100 * (@postings_applied_this_week.size / @applications_per_week)) - 100
    @application_goal = current_user.application_goal
    @progress = (@postings_applied_this_week.size.to_f / @application_goal.to_f) * 100 
  end
end
