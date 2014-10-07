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
    # HACK: Hardcode in 500 id for posting that can't be found due to default
    # scope.
    assert_select "\#posting-500", false
  end

  test "archive page should not contain active postings" do
    sign_in @user2

    get :archived
    assert_response :success

    # This fixture user has only one archived posting.
    assert_select ".job-posting", @user2.postings.archived.count
    # HACK: Hardcode in 500 id for posting that can't be found due to default
    # scope.
    assert_select "\#posting-500"
  end

  test "archive toggle should work without JSON format" do
    sign_in @user2

    assert_difference -> { Posting.where(user_id: @user2.id).archived.count } do
      patch :archivetoggle, id: postings(:one_usertwo)

      assert_response :redirect
    end
  end

  test "archive toggle should archive and unarchive a posting" do
    sign_in @user2

    assert_difference -> { Posting.where(user_id: @user2.id).archived.count } do
      patch :archivetoggle, format: :json, id: postings(:one_usertwo)

      assert_response :success
    end

    assert_difference -> { Posting.where(user_id: @user2.id).count } do
      # HACK: Hardcode in 500 id for posting that can't be found due to default
      # scope.
      patch :archivetoggle, format: :json, id: Posting.unscoped.find(500)

      assert_response :success
    end

    assert_no_difference -> {
      Posting.where(user_id: @user2.id).archived.count
    } do
      patch :archivetoggle, format: :json, id: postings(:one_usertwo)
      patch :archivetoggle, format: :json, id: postings(:one_usertwo)
    end
  end

  test "archive toggle cannot access another user's postings" do
    sign_in @user2

    assert_raises Pundit::NotAuthorizedError do
      patch :archivetoggle, id: postings(:one)

      assert_response :redirect
    end
  end

  test "archive toggle doesn't work when not signed in" do
    assert_no_difference -> {
      Posting.where(user_id: @user.id).archived.count
    } do
      patch :archivetoggle, id: postings(:one)

      assert_response :redirect
      assert_redirected_to new_user_session_path
    end
  end

  test "posting requires a position (title) and company" do
    sign_in @user

    assert_no_difference -> {
      Posting.where(user_id: @user.id).count
    } do
      post :create, posting: {
        hiring_organization: 'Mozzarella Firefox'
      }

      assert_response :success
    end

    assert_no_difference -> {
      Posting.where(user_id: @user.id).count
    } do
      post :create, posting: {
        title: 'Rodent Wrangler'
      }

      assert_response :success
    end
  end

  test "posting can be created with only a position (title) and company" do
    sign_in @user

    assert_difference -> {
      Posting.where(user_id: @user.id).count
    } do
      post :create, posting: {
        title: 'Web Developer',
        hiring_organization: 'Mozzarella Firefox'
      }

      assert_response :redirect
    end
  end
end
