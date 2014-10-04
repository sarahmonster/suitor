# Create the admin user; defaults to Sarah, but can be changed with an ENV
# variable.
User.invite!({email: ENV.fetch("ADMIN_EMAIL", "sarah@triggersandsparks.com"), role: :admin, invitation_limit: 1000000})
