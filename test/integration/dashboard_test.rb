require 'test_helper'

class DashboardTest < ActionDispatch::IntegrationTest
  test "login and use dashboard" do
    get "/login"
    assert_response :success

    post_via_redirect "/login", {
      'user[email]' => users(:one).email,
      'user[password]' => "thisismypassword"
    }
    assert_equal "/", path
  end
end
