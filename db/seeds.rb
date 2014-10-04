# Create the admin user; defaults to Sarah, but can be changed with an ENV
# variable.
User.create({email: ENV.fetch("ADMIN_EMAIL", "sarah@triggersandsparks.com"), password: ENV.fetch("ADMIN_PASSWORD", "temp_pass_please_change"), password_confirmation: ENV.fetch("ADMIN_PASSWORD", "temp_pass_please_change"), role: :admin, invitation_limit: 1000000}).confirm!
