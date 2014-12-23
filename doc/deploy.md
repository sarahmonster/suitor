# Deploying (to mrsuitor.com)

## Add the right servers to your capfile

If you're deploying to [mrsuitor.com](http://mrsuitor.com/) you don't need to
change anything in your deploy scripts.

If you're deploying anywhere else, edit your `config/deploy/production.rb`
file and add your server. It should probably look like:

```ruby
server 'mrsuitor.com', user: 'deploy', roles: %w{web app db}, primary: true
```

You are now ready to deploy suitor to a combined app/db/web server!

## Setting environment variables (including database password)

If you've never deployed to this server before (or you need to update its
`.env` file containing its environment variables--including database passwords)
you'll need to have a local `.env.$STAGE` file in the root of your git repo
for suitor, where `$STAGE` is whatever Capistrano stage you'll be deployng to.

Usually, this means having a `.env.production` file in the root of your repo
that looks like this:

```ruby
DEVISE_KEY=my_secret_key
SECRET_KEY_BASE=other_secret

FACEBOOK_APP_ID=123456789
FACEBOOK_APP_SECRET=hark_a_secret

TWITTER_KEY=lock
TWITTER_SECRET=andkey

MANDRILL_USERNAME=bob@mycooldomain.biz
MANDRILL_PASSWORD=password

GA_ID=UA-123-4

SUITOR_DB_NAME=suitor
SUITOR_DB_POOLS=5
SUITOR_DB_USERNAME=login
SUITOR_DB_PASSWORD=password
SUITOR_DB_HOST=127.0.0.1
SUITOR_DB_PORT=3306

SUITOR_HOST=http://mrsuitor.com
```

This file will be copied to the server's `shared/` folder when you run
`cap production deploy:setup_config`. If you need to copy a new version you
can run the command again to re-copy all files to the server.

## Run the first-time deploy script

> cap production deploy:setup_config

## Deploy the app

> cap production deploy

Visit [mrsuitor.com](http://mrsuitor.com/), or wherever you deployed your app.
Ta-da!
