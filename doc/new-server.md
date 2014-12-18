# Configuring a new server

This document is a step-by-step guide to create an app server that will accept
our Capistrano deploys.

> Note that this document includes info on how to set up and configure
  MySQL, redis, etc. If you're just creating an app server, skip these servers.

## Server OS, Versions, etc.

suitor (and this document) is optimised for deploys to a 64-bit, Ubuntu Linux
(`14.10` LTS) Linode VPS. The recommended Ruby version is `2.1.5` using
[rbenv](https://github.com/sstephenson/rbenv). We use nginx as our web server,
with Phusion Passenger to run our Ruby code.

> Log in as `root` for now.

## Add your app's user

We call our user `suitor`, but you can call it whatever you want. This is the
user that runs our Rails app.

```bash
adduser suitor # enter a password, info, etc.
chsh -s /bin/bash suitor # change shell to slightly nicer bash
```

Allow this user to `sudo`:

```bash
visudo
```

Find the line with `root    ALL=(ALL:ALL) ALL` in it, and underneath add
`suitor  ALL=(ALL:ALL) NOPASSWD:ALL` so it looks like:

```
root    ALL=(ALL:ALL) ALL
suitor  ALL=(ALL:ALL) NOPASSWD:ALL
```

Finally, allow yourself access by adding an ssh key:

```bash
su - suitor
mkdir .ssh
# Paste in the public key of any machines allowed to deploy here:
vim .ssh/authorized_keys
```

After you save that file, disable password login for the `suitor` user,
set the permissions and log out:

```bash
chmod 700 .ssh
chmod 600 .ssh/authorized_keys
logout
passwd -l suitor
```

## Update and install software

```bash
apt-get update
apt-get install git gcc autoconf bison build-essential libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev libsqlite3-dev
```

# Install and configure MySQL

We'll need a database server and we write against MySQL. Installation and
setup is straightforward enough:

```bash
apt-get install mysql-server
```

Then set your MySQL root password. Write it down somewhere. We'll assume it's
"`password`"

Now create your app's user:

```bash
mysql -u root -ppassword
```

```mysql
CREATE USER 'suitor'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
exit
```

Again, set a real password; this guide assumes "`password`".

> We are going to assume a `localhost`-only for this guide; if you are running
  a MySQL server elsewhere that multiple app servers connect from, be sure it
  can connect from other hosts.

## Install rbenv

> You will be running the following as the app/deploy user (the default is
  `suitor`), but the code below does that for you; there is no need to switch
  users manually.

This will install rbenv **only for the `suitor` user** (this is by design).
You can copy and paste these instructions; they require no user input.

```bash
su - suitor

curl -L https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash

echo '
export RBENV_ROOT="${HOME}/.rbenv"

if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi
' >> ~/.bashrc
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
source ~/.bashrc

rbenv install 2.1.5
rbenv rehash
rbenv global 2.1.5

# gem install rdoc
# gem install bundler
# gem install rake
# rbenv rehash
```

# Install nginx + Passenger

> We're going to do this as `suitor`, hence the sudo calls.

```bash
# Install Phusion's PGP key to verify packages
gpg --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
gpg --armor --export 561F9B9CAC40B2F7 | sudo apt-key add -

# Add HTTPS support to APT
sudo apt-get install apt-transport-https

# Add the passenger repository
sudo sh -c "echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main' >> /etc/apt/sources.list.d/passenger.list"
sudo chown root: /etc/apt/sources.list.d/passenger.list
sudo chmod 600 /etc/apt/sources.list.d/passenger.list
sudo apt-get update

# Install nginx and passenger
sudo apt-get install nginx-full passenger

# Start the service
sudo service nginx start

# Rehash rbenv
rbenv rehash
```

You need to edit `/etc/nginx/nginx.conf`:

```bash
sudo vim /etc/nginx/nginx.conf
```

Replace existing "`#Passenger config`" block with:

```
	# Phusion Passenger config
	passenger_root /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini;
	passenger_ruby /home/suitor/.rbenv/shims/ruby;
```

You also need to edit `/etc/nginx/sites-enabled/default`:

```bash
sudo vim /etc/nginx/sites-enabled/default
```

Replace existing "`root`" declaration above "`server_name localhost;`" with:

```
	server_name       mrsuitor.com;
	passenger_enabled on;
	rails_env         production;
	root              /home/suitor/railsapp/current/public;
```

Restart nginx:

```bash
sudo service nginx start
```

nginx is now configured! (Though it will 404 as our app's folder doesn't exist
yet.)







---

```bash
bundle install --deployment --binstubs
```
