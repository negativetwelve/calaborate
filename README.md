# Cal-aborate

### Installation

Make sure you're using Ruby 1.9.3

    bundle install
    rake db:migrate
    rails server

Go to localhost:3000 to see your site.

### Testing Locally

You need to create a Facebook Developer App in order to test the app locally.

Go Here: https://developers.facebook.com/apps
Create a new app.
Set the FACEBOOK_APP_ID and FACEBOOK_SECRET environment variables.

You might encounter problems with Postgres. If you have a Mac, use Brew to install Postgres.

    brew install postgres

Make sure you restart your computer and if you're still having issues, run these commands:

  rm -rf /usr/local/var/postgres

  sudo sysctl -w kern.sysv.shmall=65536

  sudo sysctl -w kern.sysv.shmmax=16777216

  initdb /usr/local/var/postgres -E utf8

  launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

  cp /usr/local/Cellar/postgresql/9.2.3/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/

  launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

  createdb calaborate_development

If that doesn't work, there are many StackOverflow posts that hopefully will be able to solve your problem.

### Working with the Database

Fire up the Rails Console

    rails console

From there you can query the database, for example:

    User.all
    Course.all

    u = User.first
    u.courses

The first command gets all the users, the second gets all the courses. The third gets the first user on the app and the fourth line grabs all the user's courses.