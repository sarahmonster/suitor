# suitor

suitor is a Rails 4.0 web application for tracking your job applications. It
allows you to track what jobs you've applied for, when you did it, what your
cover letter was, and encourages you to follow-up and track the entire
application process.

# Installation / Setup

suitor is a Rails app (built with Rails 4.0 and developed mostly on OS X using
Ruby 2.1.0), so you'll need to have [Ruby][] installed. After that, run:

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

Now you're ready to start hacking on suitor! You'll want to run the initial
database migrations to get the development database set up:

```bash
rake db:migrate
```

Finally, to run the rails server:

```bash
rails server
```

Now your development version of suitor is available at [localhost][]

[localhost]: http://localhost:3000/
[Ruby]: http://www.ruby-lang.org/

---

Copyright (c) 2014 [sarah ✈ semark](http://triggersandsparks.com).
