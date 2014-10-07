require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
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

  test "user controller POST doesn't exist" do
    assert_raises ActionController::UrlGenerationError do
      post :create, user: users(:two)
    end
  end

  test "cannot view another user's profile" do
    assert_raises ActionController::UrlGenerationError do
      get :show, id: users(:two)
    end
  end

  test "cannot mark an existing user as admin" do
    assert_raises ActionController::UrlGenerationError do
      patch :update, id: @user, user: {role: 1}
      assert_redirected_to user_path(assigns(:user))
      assert_not User.find(@user).admin?
    end
  end

  test "cannot mark a new user as admin" do
    assert_raises ActionController::UrlGenerationError do
      email = Faker::Internet.free_email
      post :create, user: {email: email, role: 1}
      assert_not User.find(email: email).admin?
    end
  end

  test "cannot edit own user's profile" do
    assert_raises ActionController::UrlGenerationError do
      get :edit, id: @user
    end
  end

  test "cannot edit another user's profile" do
    assert_raises ActionController::UrlGenerationError do
      get :edit, id: users(:two)
    end
  end

  test "cannot update own user's profile" do
    assert_raises ActionController::UrlGenerationError do
      patch :update, id: @user
    end
  end

  test "cannot update another user's profile" do
    assert_raises ActionController::UrlGenerationError do
      patch :update, id: users(:two)
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
