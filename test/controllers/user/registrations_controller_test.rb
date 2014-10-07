require 'test_helper'

class User::RegistrationsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)

    @email = Faker::Internet.email
    @password = Faker::Internet.password(8)
  end

  test "sign up page should exist" do
    get :new

    assert_response :success
  end

  test "sign up page should redirect if user is logged in" do
    sign_in @user

    get :new

    assert_redirected_to dashboard_path
  end

  test "user can create an account" do
    assert_difference('User.count') do
      post :create, user: {
        email: @email,
        password: @password
      }

      assert_response :redirect
    end
  end

  test "user must confirm an email+password account" do
    post :create, user: {
      email: @email,
      password: @password
    }

    assert_response :redirect

    assert_nil User.where(email: @email).first.confirmed_at
  end

  test "sign up without email should not create a user" do
    assert_no_difference('User.count') do
      post :create, user: {
        password: @password,
        password_confirmation: @password
      }

      assert_response :success
    end
  end

  test "sign up with blank/invalid email should not create a user" do
    assert_no_difference('User.count') do
      password = Faker::Internet.password(8)

      post :create, user: {
        email: 'iamanemail.com',
        password: @password
      }

      assert_response :success
    end

    assert_no_difference('User.count') do
      password = Faker::Internet.password(8)

      post :create, user: {
        email: ' ',
        password: @password
      }

      assert_response :success
    end
  end

  test "sign up without password should not create a user" do
    email = Faker::Internet.email
    password = Faker::Internet.password(8)

    assert_no_difference('User.count') do
      post :create, user: {email: @email}

      assert_response :success
    end
  end

  test "password must not suck" do
    assert_no_difference('User.count') do
      post :create, user: {
        email: @email,
        password: Faker::Internet.password(3)
      }

      assert_response :success
    end
  end

  test "password can be huge" do
    assert_no_difference('User.count') do
      post :create, user: {
        email: @email,
        password: Faker::Internet.password(300)
      }

      assert_response :success
    end
  end

  test "user doesn't have to confirm their password" do
    assert_difference('User.count') do
      post :create, user: {
        email: @email,
        password: @password
      }

      assert_response :redirect
    end
  end

  test "user can confirm their password" do
    assert_difference('User.count') do
      post :create, user: {
        email: @email,
        password: @password,
        password_confirmation: @password
      }

      assert_response :redirect
    end
  end

  test "user password confirmations must match if they exist" do
    assert_no_difference('User.count') do
      post :create, user: {
        email: @email,
        password_confirmation: @password
      }

      assert_response :success
    end

    assert_no_difference('User.count') do
      post :create, user: {
        email: @email,
        password: 'password',
        password_confirmation: 'password1'
      }

      assert_response :success
    end
  end
end
