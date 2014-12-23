source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

# Production-only gems
group :production do
  # Use dotenv to deploy secrets with Capistrano
  gem 'dotenv-deployment', require: 'dotenv/deployment'

  # MySQL in production
  gem 'mysql2'

  # Email me when errors happen!
  gem 'exception_notification'
  gem 'browser_details'
end

# Development and test-only gems
group :development, :test do
  # For fixture data
  gem 'faker'

  # Fixes issue with Rails tests with guard.
  gem 'ruby-prof'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

# Better Development
group :development do
  gem 'better_errors'

  # We use capistrano to deploy our app.
  gem 'capistrano', '~> 3.2.1'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-upload-config', :git => 'git://github.com/tofumatt/capistrano-upload-config.git'
  # These are capistrano helpers for the chef setup used by mrsuitor.com
  gem 'capistrano-cookbook', require: false

  # Run tasks on file update with guard.
  gem 'guard'
  # Run tests on save.
  gem 'guard-minitest'

  gem 'quiet_assets'
  gem 'rails-footnotes', '>= 4.0.0', '<5'
  gem 'spring'
end

group :test do
  # Client tests
  gem 'capybara'
  gem 'poltergeist'
  # gem 'selenium-webdriver'

  # Use Sauce Labs for browser testing.
  gem 'sauce'
  gem 'sauce-connect'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# We run rails server with unicorn
gem 'unicorn', '~> 4.8.3'

# Use dotenv to manage secrets and things of that nature
gem 'dotenv-rails'

# Add pirate translations for testing and fun and profit!
gem 'talk_like_a_pirate'

# Use ActiveModel has_secure_password
gem 'bcrypt'

# Inline CSS used in emails
gem 'premailer-rails'
gem 'nokogiri', '~> 1.6.3'

# Page caching.
gem 'dalli'
gem 'actionpack-page_caching'

# User authentication
gem 'devise'
gem 'devise_invitable'
gem 'omniauth-facebook'
gem 'pundit'

# Better than Struct.new
# See: http://thepugautomatic.com/2013/08/struct-inheritance-is-overused/
gem 'attr_extras'

# Integrate Jekyll blog
gem 'jekyll'
gem 'redcarpet'
gem 'rouge'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Bourbon for mixins and stuff
gem 'bourbon'
gem 'neat'

# Use Froala for WYSIWYG editing (requires FontAwesome) and pickadate for time/date input
gem 'font-awesome-rails'
gem 'wysiwyg-rails'
gem 'pickadate-rails'
gem 'date_time_attribute'

# Use Vex for modal windows
gem 'vex_rails', :git => 'git://github.com/sarahsemark/vex_rails.git'

# Use a custom-updated version of mmenu for the mobile menu
gem 'mmenu-rails', :git => 'git://github.com/sarahsemark/mmenu-rails.git'

# Encode email addresses, because I'm that kind of paranoid
gem 'actionview-encoded_mail_to'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-sass-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'
