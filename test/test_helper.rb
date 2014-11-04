ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Set valid mock data for all OmniAuth providers.
  def mock_omniauth
    OmniAuth.config.test_mode = true

    OmniAuth.config.add_mock(:facebook,
      provider: "facebook",
      uid: "1234",
      info: {
        email: "zuck@facebook.com",
        name: "Mark Zuckerberg"
      }
    )

    if request
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    end
  end

  # Set invalid mock data for all OmniAuth providers.
  def mock_invalid_omniauth
    OmniAuth.config.mock_auth[:facebook] = :invalid_crendentials
  end
end

class ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  setup do
    Capybara.default_driver = :poltergeist
  end
end
