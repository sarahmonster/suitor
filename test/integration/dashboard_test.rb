require 'test_helper'

class DashboardTest < ActionDispatch::IntegrationTest
  test "login and use dashboard" do
    get login_path
    assert_response :success

    post_via_redirect login_path, user: {
      email: users(:one).email,
      password: "thisismypassword"
    }
    assert_equal root_path, path
  end

  test "login and use dashboard, create a posting and apply to it, then visit
        the dashboard again" do
    get login_path
    assert_response :success

    post_via_redirect login_path, user: {
      email: users(:no_postings).email,
      password: "thisismypassword"
    }
    assert_equal root_path, path

    get new_posting_path
    assert_response :success

    post_via_redirect postings_path, posting: {
      title: "Y2K Analyst", hiring_organization: "Initech"
    }
    assert_match /\/postings\/\d+/, path
    path_to_posting = path
    path_to_create_job_application = "#{path}/job_application"

    get postings_path
    assert_response :success

    post_via_redirect path_to_create_job_application, job_application: {
      date_applied: Date.today
    }
    assert_equal path_to_posting, path

    get root_path
    assert_response :success
  end
end
