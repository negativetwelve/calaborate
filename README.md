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

### Testing Database

Fire up the Rails Console

    rails console

From there you can query the database, for example:

    User.all
    Course.all

    u = User.first
    u.courses

The first command gets all the users, the second gets all the courses. The third gets the first user on the app and the fourth line grabs all the user's courses.