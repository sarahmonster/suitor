# suitor [![Build Status](https://secure.travis-ci.org/sarahsemark/suitor.png?branch=master)](http://travis-ci.org/sarahsemark/suitor)

suitor is a Rails 4.1 web application for tracking your job applications. It
allows you to track what jobs you've applied for, when you did it, what your
cover letter was, and encourages you to follow-up and track the entire
application process.

# Installation / Setup

suitor is a Rails app (built with Rails 4.1 and developed mostly on OS X using
Ruby 2.1), so you'll need to have [Ruby][] installed. After that, run:

```bash
gem install bundler rails
```

To get bundler and rails installed. After that, check out suitor and install
its dependencies:

```bash
git clone https://github.com/sarahsemark/suitor.git
cd suitor
bundle install
```

Now you're ready to start hacking on suitor! Instead of running migrations
one-by-one when you start developing, you're better off running `rake db:setup`
This will install the admin user for you as well as run all the initial
migrations. You can use a custom email for the admin user by specifying an
environment variable:

```bash
ADMIN_EMAIL=youremail@gmail.com ADMIN_PASSWORD=yourpassword rake db:setup
```

Finally, to run the rails server:

```bash
rails server
```

Now your development version of suitor is available at [localhost][].

[localhost]: http://localhost:3000/
[Ruby]: http://www.ruby-lang.org/


# License information

Mail templates based on [the always fantastic MailChimp](http://www.mailchimp.com/)'s [email blueprints](https://github.com/mailchimp/Email-Blueprints), originally licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License](http://creativecommons.org/licenses/by-sa/3.0/).

Background patterns from my go-to resource, the [Subtle Patterns library](http://subtlepatterns.com), also licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License](http://creativecommons.org/licenses/by-sa/3.0/).

Copyright (c) 2014 [sarah ✈ semark](http://triggersandsparks.com).
