require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @user2 = users(:two)
    @admin = users(:admin)
  end

  test "should redirect to login if not authorized to access dashboard" do
    get :index
    assert_redirected_to login_path
  end

  test "should show dashboard to authorized user" do
    sign_in @user

    get :index
    assert_response :success
  end

  test "should show dashboard to admin" do
    sign_in @admin

    get :index
    assert_response :success
  end
end
