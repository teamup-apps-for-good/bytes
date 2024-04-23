# README

Bytes - Meal Plan sharing for those in need

# How to get started for development

Our project uses Google OAuth and there is a client secret & key associated with your Google account so Google knows who is using their services. 

(adapted from the Rails OAuth activity we did in January)
1. You'll need to create a project in the Google Developer Console
2. In settings for that project, go to APIs & Services, and go to the Oauth consent screen.
3. Fill out required information i.e. app name, etc
4. When on the scopes step, add userinfo.email and userinfo.profile. Save and submit
5. Click Credentials, and Create Credentials
6. Select OAuth Client ID and choose Web application as app type. Give it a name
7. Under authorized redirect uris add: http://localhost:3000/auth/google_oauth2/callback & http://127.0.0.1:3000/auth/googleoauth2/callback and click create. You'll get a client id and client secret, save this
8. Go to your google account settings, and find App passwords section 
9. Create a new app specific password and remember the passkey for the credentials
10. Delete the current config/credentials.yml.enc file 
11. Using the command VISUAL="vim" rails credentials:edit create a new credentials file and add this text:
```yaml
    google:
      client_id: your_client_id
      client_secret: your_client_secret
    gmail:
      username: your_email_address
      password: your_email_passkey
	  feedback_target: feedback_email_target_address
```



After cloning, all gems needed should already be in the gem file. You need to run bundle install to install all dependencies, then rails db:create to start a new database.

# How to run tests

To run rspec tests run **rspec** in the terminal, to run cucumber tests run **rails cucumber** in the terminal.

# How to deploy

To run/deploy locally, run **rails s** to start
To run your own version on heroku (for whatever reason), you'll need to clone the repo, and run **heroku create -a <name>** and do the getting started steps using the **heroku run** prefix

# How to contact

To contact about questions, email thebytesteam2024@gmail.com
