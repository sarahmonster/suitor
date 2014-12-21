# Load DSL and set up stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# These are required for our mrsuitor.com deploy.
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/cookbook'
require 'capistrano/upload-config'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
