# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'suitor'
set :deploy_user, 'deploy'

set :scm, :git
set :repo_url, 'https://github.com/sarahsemark/suitor.git'

# These are the rbenv settings for mrsuitor.com app servers:
set :rbenv_type, :system
set :rbenv_ruby, '2.1.5'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# We keep the last 5 deploys; good enough.
set :keep_releases, 5

# The .env is all we copy. We don't copy database.yml or secrets.yml because
# we use dotenv and environment variables for our secrets.
set :linked_files, %w{.env}

# These are the dirs we keep between releases
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do
end
