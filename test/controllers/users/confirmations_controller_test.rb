require 'test_helper'

class Users::ConfirmationsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)

    @email = Faker::Internet.email
    @password = Faker::Internet.password(8)
  end
end
