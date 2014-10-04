require 'test_helper'

class PostingsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @user2 = users(:two)
  end

  test "should redirect to login if not authorized to see postings" do
    get :index
    assert_redirected_to new_user_session_path
  end

  test "should redirect to login if not authorized to see archived postings" do
    get :archived
    assert_redirected_to new_user_session_path
  end

  test "should get index if authorized" do
    sign_in @user

    get :index
    assert_response :success

    assert_not_nil assigns(:method)
    assert_not_nil assigns(:sortorder)
  end

  test "importance is the default sort order for postings index" do
    sign_in @user

    get :index
    assert_response :success

    assert_equal assigns(:sortorder), 'importance'
  end

  test "should get index of archived postings if authorized" do
    sign_in @user

    get :archived
    assert_response :success

    # Sent to the view to make cacheable views
    assert_equal assigns(:method), :archived
    assert_not_nil assigns(:archive_page)
  end

  test "should respect good listing sort order" do
    sign_in @user

    get :index, sort: 'date-added'
    assert_response :success

    assert_equal assigns(:method), [:order, 'created_at DESC']
    assert_not_nil assigns(:sortorder)
  end

  test "should not respect invalid listing sort order" do
    sign_in @user

    get :index, sort: 'date-the-dog-barked-loudly'
    assert_response :success

    assert_equal assigns(:method), :sorted_by_importance
    assert_not_nil assigns(:sortorder)
  end

  test "index page should not contain archived postings" do
    sign_in @user2

    get :index
    assert_response :success

    assert_select ".job-posting"
    assert_select "\#posting-500", false
  end

  test "archive page should not contain active postings" do
    sign_in @user2

    get :archived
    assert_response :success

    # This fixture user has only one archived posting.
    assert_select ".job-posting", @user2.postings.archived.count
    assert_select "\#posting-500"
  end
end
