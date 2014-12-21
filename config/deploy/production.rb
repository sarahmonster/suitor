# mrsuitor.com app servers, yo!
set :stage, :production

# We always deploy from master.
set :branch, "master"

# These are the hostnames to which our nginx server will respond. Keep in
# mind that ONLY THE HOSTNAMES HERE WILL GET A RESPONSE FROM OUR HTTP SERVER.
# They specify our VirtualHost directives in the nginx config on the server,
# so if you don't have DNS set up for these hosts, you'll need to edit your
# /etc/hosts or the requests will fail. You cannot make straight-up IP requests
# to these servers by default.
set :server_name, "mrsuitor.com www.mrsuitor.com"

# This is useful if we're running multiple apps on the same app server (we
# currently don't, but it's possible). It also provides sanity checks when
# looking at file paths, especially if you have a server that runs different
# stages of the same app (staging and production).
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

# These are the servers we deploy our app to. Note that these are not the
# hostnames that the servers will respond to re: HTTP requests but they are
# the internally-used hostnames. Things like `cyrano.mrsuitor.com` are fine
# here.
#
# Servers that include the `db` role are database servers.
server 'cyrano.mrsuitor.com', user: 'deploy', roles: %w{web app db}, primary: true

# Where we deploy the app. Simple enough ;-)
set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/#{fetch(:full_app_name)}"

# Instead of trying to infer something as important as environment from the
# stage name, we'll set it explicitly here:
set :rails_env, :production

# Number of unicorn workers, this will be reflected in the unicorn.rb and monit
# configs.
set :unicorn_worker_count, 5

# Whether we're using ssl or not, used for building nginx config files.
# For now it's off, but this should change in the future.
# TODO: Enable SSL.
set :enable_ssl, false
