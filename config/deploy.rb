# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'suitor'
set :repo_url, 'https://github.com/sarahsemark/suitor.git'
set :deploy_via, :remote_cache # Don't re-download the entire git repo on each deploy

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
# set :branch, ENV['BRANCH'] || "master"
# set :branch, "deploy"

# Bundler Flags
set :bundle_flags, "--deployment --quiet --binstubs"

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/suitor/railsapp'

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml .env}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# rbenv
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.1.5'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

namespace :deploy do
  # namespace :assets do
  #   task :precompile do
  #     from = source.next_revision(current_revision)
  #     if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
  #       logger.info "Precompile assets."
  #       run "cd #{release_path} && bundle exec rake RAILS_ENV=#{rails_env} RAILS_GROUPS=assets assets:precompile"
  #     else
  #       logger.info "Skipping asset pre-compilation because there were no asset changes"
  #     end
  #   end
  # end

  # namespace :db_migrations do
  #   task :migrate do
  #     from = source.next_revision(current_revision)
  #     if capture("cd #{latest_release} && #{source.local.log(from)} db/migrate | wc -l").to_i > 0
  #       run "cd #{current_release} && RAILS_ENV=#{rails_env} bundle exec rake db:migrate"
  #       logger.info "New migrations added - running migrations."
  #     else
  #       logger.info "Skipping migrations - there are not any new."
  #     end
  #   end
  # end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence do
      # This restarts Passenger
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end

after 'deploy:update_code', 'deploy:migrate'
