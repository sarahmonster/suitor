# Configuring a new server

This document is a step-by-step guide to create an app server that will accept
our Capistrano deploys.

## Required software to deploy

You'll need Capistrano, Chef, and some other tools installed. TODO: Cover this
more later.

You'll also want the `ssh-copy-id` utility installed to streamline the key
copy process. On a Mac, you can install this with `brew`:

> brew install ssh-copy-id

## Server OS, Versions, etc.

suitor (and this document) is optimised for deploys to a 64-bit, Ubuntu Linux
(`14.04` LTS) Linode VPS. The version of Ruby used in production is `2.1.5`
(using [rbenv](https://github.com/sstephenson/rbenv)). We use nginx as our
web server, with Unicorn to run our Ruby code.

## Create a new Linode

Create a new Linode, then add your ssh-key to it for password-less root access:

> ssh-copy-id root@SERVER_IP

## Provision the server

TODO: Explain which roles should be used for which kinds of server.

For now we assume the defaults are good. Run:

> knife solo bootstrap root@SERVER_IP

and `chef` will do its thing. This includes building Ruby, installing a lot of
packages, and other things. Go get a cup of coffee.

## Add this server to your capfile

TODO: Explain this.

## Run the first-time deploy script

> cap production deploy:setup_config

## Deploy the app

> cap production deploy

Ta-da!
