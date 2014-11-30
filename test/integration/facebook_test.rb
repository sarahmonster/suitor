require 'test_helper'

class FacebookTest < ActionDispatch::IntegrationTest
  # setup do
  #   mock_omniauth
  # end

  # test "login, use dashboard, logout, login, and get new message" do
  #   mock_omniauth

  #   visit signup_path

  #   assert page.has_selector?('#facebook'), "Facebook login should be available"

  #   within("#signup-form") do
  #     find('#facebook').click
  #   end

  #   # Redirected back to suitor.
  #   assert page.has_text?("Hello, Mark Zuckerberg."), # See mock_omniauth
  #                                                     # for info.
  #          "User should be redirected to the dashboard with their user info " +
  #          "from Facebook included on the page."
  #   assert page.has_no_text?("Welcome back"),
  #          "Welcome back text should not appear on first log in"

  #   # Log out of suitor.
  #   find('footer.logout a').click

  #   assert page.has_text?("Signed out successfully."),
  #          "User should be signed out"
  # end
end
