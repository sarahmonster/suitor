Suitor::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Use the memory store for development caching stuff.
  config.cache_store = :memory_store

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Set up mailer URLS
  config.action_mailer.default_url_options = { :host => 'localhost', :port => 3000 }
  config.action_controller.asset_host =
  config.action_mailer.asset_host     = 'http://localhost:3000/'

  # Use the MailCatcher gem if it's set up
  if ENV["MAILCATCHER"] == "true"
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_deliveries = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }

  # Alternatively, use Mandrill if environment variables are set
  elsif ENV["MANDRILL_USERNAME"] 
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_deliveries = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address   => "smtp.mandrillapp.com",
      :port      => 587,
      :user_name => ENV["MANDRILL_USERNAME"],
      :password  => ENV["MANDRILL_PASSWORD"],
      :enable_starttls_auto => true, 
      :authentication => 'login', 
      :domain => 'localhost'
    }

  # Otherwise don't bother sending mail
  else
    config.action_mailer.raise_delivery_errors = false
    config.action_mailer.perform_deliveries = false
  end

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Let's set a timezone so I get less confused
  config.time_zone = 'Eastern Time (US & Canada)'
end
