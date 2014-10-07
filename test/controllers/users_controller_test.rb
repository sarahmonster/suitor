require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @user2 = users(:two)
  end

  test "user index should not exist" do
    assert_raises ActionController::UrlGenerationError do
      get :index
    end
  end

  test "new user cannot be created from controller" do
    assert_raises ActionController::UrlGenerationError do
      get :new
    end
  end

  test "user can update their own profile" do
    sign_in @user

    patch :update, user: {name: 'Slim Shady'}

    assert_response :redirect
  end

  test "user cannot update another user's profile" do
    sign_in @user2

    assert_raises Pundit::NotAuthorizedError do
      patch :update, id: @user.id, user: {name: 'Slim Shady'}
    end
  end

  test "cannot view profiles" do
    assert_raises ActionController::UrlGenerationError do
      get :show, id: users(:two)
    end
  end

  test "cannot mark an existing user as admin" do
    sign_in @user

    patch :update, id: @user, user: {role: 1}

    assert_not User.find(@user.id).admin?
  end

  # test "cannot mark a new user as admin" do
  #   email = Faker::Internet.free_email
  #   post :create, user: {email: email, role: 1}
  #   assert_not User.find(email: email).admin?
  # end

  test "can edit own user's profile" do
    sign_in @user

    get :edit

    assert_equal assigns(:user), @user
  end

  test "cannot edit another user's profile" do
    sign_in @user

    assert_raises Pundit::NotAuthorizedError do
      get :edit, id: @user2
    end
  end

  test "cannot delete own user's profile" do
    assert_raises ActionController::UrlGenerationError do
      delete :destroy, id: @user
    end
  end

  test "cannot delete another user's profile" do
    assert_raises ActionController::UrlGenerationError do
      delete :destroy, id: users(:two)
    end
  end
end
