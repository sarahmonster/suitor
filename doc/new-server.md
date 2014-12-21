# Configuring a new server

This document is a step-by-step guide to create an app server that will accept
our Capistrano deploys.

We use `berkshelf`, `chef`, and `knife-solo` to deploy to
[mrsuitor.com](http://mrsuitor.com/). Right now our deploy scripts and process
are private, but we're looking to open source them in the future.

To provision a new server, you can check out the server configs and run
`bundle install`.

You'll also want the `ssh-copy-id` utility installed to streamline the key
copy process. On a Mac, you can install this with `brew`:

> brew install ssh-copy-id

## Server OS, Versions, etc.

suitor (and this document) is optimised for deploys to a 64-bit, Ubuntu Linux
(`14.04` LTS) Linode VPS. The version of Ruby used in production is `2.1.5`
(using [rbenv](https://github.com/sstephenson/rbenv)). We use nginx as our
web server, with Unicorn to run our Ruby code. Our database server is MySQL
and we run `memcached` and `redis` in production.

## Create a new Linode

Create a new Linode, then add your ssh-key to it for password-less root access:

> ssh-copy-id root@SERVER_IP

## Provision the server

For now we assume the defaults are good, as
[mrsuitor.com](http://mrsuitor.com/) is currently a one-server setup. Run:

> knife solo bootstrap root@SERVER_IP

and `chef` will do its thing. This includes building Ruby, installing a lot of
packages, and other things. Go get a cup of coffee.

Once everything is finished you should see `chef` complete with no errors
and the message `Chef Client finished`. Congrats! Your server is now running,
but don't bother trying to see the "Welcome to nginx!" page. The server won't
respond to bare IP requests; our capistrano deploy will get it serving actual
content!

## Deploy

Check out the deploy docs (`docs/deploy.rb`) to see how to deploy suitor to
your new server for the first time, what files you'll need, and how to run
subsequent deploys.
