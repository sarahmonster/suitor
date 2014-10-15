require 'test_helper'

class DashboardTest < ActionDispatch::IntegrationTest
  test "login and use dashboard" do
    get "/login"
    assert_response :success

    post_via_redirect "/login", user: {
      email: users(:one).email,
      password: "thisismypassword"
    }
    assert_equal "/", path
  end

  test "login and use dashboard, create a posting and apply to it, then visit
        the dashboard again" do
    get "/login"
    assert_response :success

    post_via_redirect "/login", user: {
      email: users(:no_postings).email,
      password: "thisismypassword"
    }
    assert_equal "/", path

    get "/postings/new"
    assert_response :success

    post_via_redirect "/postings", posting: {
      title: "Y2K Analyst", hiring_organization: "Initech"
    }
    assert_match /\/postings\/\d+/, path
    path_to_posting = path
    path_to_create_job_application = "#{path}/job_applications"

    get "/postings"
    assert_response :success

    post_via_redirect path_to_create_job_application, job_application: {
      date_applied: Date.today
    }
    assert_equal path_to_posting, path

    get "/"
    assert_response :success
  end
end
