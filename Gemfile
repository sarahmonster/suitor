source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'

# Use dotenv to manage secrets and things of that nature
gem 'dotenv-rails'

# Development and test-only gems
group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

gem 'mysql2'

# Better Development
group :development do
  gem 'better_errors'
  gem 'quiet_assets'
  gem 'rails-footnotes', '>= 4.0.0', '<5'
  gem 'spring'
  gem 'seed_dump'
end

# Production-only gems
group :production do
  # Use dotenv to deploy secrets with Capistrano
  gem 'dotenv-deployment', require: 'dotenv/deployment'

  # MySQL in production
  gem 'mysql2'

  gem 'capistrano', '~> 3.1.0'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1.1'
  gem 'capistrano-rvm', github: "capistrano/rvm"
end

# User authentication
gem 'devise'
gem 'pundit'
gem 'omniauth-facebook'

# Better than Struct.new
# See: http://thepugautomatic.com/2013/08/struct-inheritance-is-overused/
gem 'attr_extras'

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

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Add pirate translations for testing and fun and profit!
gem 'talk_like_a_pirate'

# Use ActiveModel has_secure_password
gem 'bcrypt'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
