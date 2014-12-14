require 'test_helper'

class JobApplicationTest < ActiveSupport::TestCase
  test "only one JobApplication per Posting" do
    posting = postings(:unique_tester)
    posting.save

    job_application = JobApplication.new({posting: posting})
    assert job_application.save, "First JobApplication should be saved"

    repeat_job_application = JobApplication.new({posting: posting})
    assert_not repeat_job_application.save, "Second JobApplication should not be saved"
  end
end
