require 'test_helper'

class PostingsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should redirect to login if not authorized to see postings" do
    get :index
    assert_redirected_to new_user_session_path
  end

  test "should get index if authorized" do
    sign_in @user

    get :index
    assert_response :success

    # Sent to the view to make cacheable views
    assert_not_nil assigns(:method)
    assert_not_nil assigns(:sortorder)
  end
end
