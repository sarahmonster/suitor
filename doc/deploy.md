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

## Run the first-time deploy script

> cap production deploy:setup_config

## Deploy the app

> cap production deploy

Visit [mrsuitor.com](http://mrsuitor.com/), or wherever you deployed your app.
Ta-da!
