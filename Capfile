# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Includes tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#
# require 'capistrano/rvm'
# require 'capistrano/rbenv'
# require 'capistrano/chruby'
# require 'capistrano/bundler'
# require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }

require 'capistrano/rails'
require 'capistrano/rails/migrations'

# rvm configuration
#require 'capistrano/rvm'
#set :rvm_custom_path, '/usr/local/rvm'
#set :rvm_ruby_version, '2.1.3p242'

# bundler configuration
require 'capistrano/bundler'
set :bundle_path, '/usr/local/rvm/gems/ruby-2.1.3@global/bin/bundle' 
