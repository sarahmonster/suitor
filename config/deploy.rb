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

# Our DB configs and .env are all we copy. We don't copy secrets.yml because
# we use dotenv and environment variables for our secrets.
set :linked_files, %w{config/database.yml .env}

# These are the dirs we keep between releases
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  # desc 'Restart application'
  # task :restart do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     # Your restart mechanism here, for example:
  #     # execute :touch, release_path.join('tmp/restart.txt')
  #   end
  # end

  # after :publishing, :restart

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end

  desc "checks whether the currently checkout out revision matches the
        remote one we're trying to deploy from"
  Rake::Task["deploy:check_revision"].clear_actions
end
