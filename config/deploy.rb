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

# This will copy over any files we name as linked files above (see:
# `set :linked_files`) from our machine, IF they exist (which they probably
# should).
#
# This looks for versions with -stage appended to the end of the filename,
# so if you are deployng to the production stage, a `.env-production` file will
# be uploaded to `shared/.env` on the server and used.
#
# This allows us to copy the environment files during setup, meaning we can
# run cap depoloy:setup_config && cap deploy to run a newly provisioned server
# from scratch. Nice!
set :upload_config_files, fetch(:linked_files)
after 'deploy:setup_config', 'config:push'

namespace :deploy do
end
