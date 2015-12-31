# How to run the application

Clone this repository at your preferred location. After that, access the folder with a terminal application and run bundle install so the app dependencies are properly installed. By doing so, you can already preview the routes available in this sample app: 

  - /login - A sample user login page.
  - /logout - Has no view, only functionality. Can only be accessed through the DELETE htpp method.
  - /register - A sample user register page.
  - /home - Only viewable after login, just shows a default, static content.
  - /password/new - A page to send an e-mail in case the user has forgotten his password.
  - /password/edit - Allows to user to edit his password (assuming he has come from the forgotten password e-mail.)
  - /verification/new - Resends the verification e-mail to the user.

However, despite being able to preview the routes, the register process won't work because you still have to setup the email server and generate the database.

## Setting up the email server

For the development of this application, a gem called [Mailcatcher](http://mailcatcher.me/) was used. To obtain and use it according the the configurations used in this application, please open a terminal application and do the following:

```sh
$ gem install mailcatcher
$ mailcatcher --smtp-port 2000 --http-port 2001
```

In such way, the mailcatcher server is started, and will be sending and capturing the e-mails generated by the application. You can then open [http//127.0.0.1:2001](http//127.0.0.1:2001) in your browser (assuming you set the http-port as specified above) and see a simple e-mail viewer client. For further information about mailcatcher, please visit their [website](http://mailcatcher.me/).

## Generating the database

For development and testing, the default sqlite database was used. To generate the development and test databases, simply open a terminal application, navigate to the application folder and do the following:

```sh
$ rake db:migrate
$ rake db:migrate RAILS_ENV=test 
```

And, after that, you can finally test the application properly, either manually or through the rake test command.

## Testing through rake

Simply go the the application folder in the terminal and type:

```sh
$ rake test
```

That should run the tests contained in the user_flows_test.rb file. The libraries used for testing were rail's default minitest library together with the capybara gem in order to simulate user interaction. The following tests were done to ensure some things were working as they should:

- **Redirection tests:** The first two tests consider that an unlogged user will be redirected to the login page. Those tests are labeled as _"root redirects to login page"_ and _"home redirects to login page"_.
- **Alphanumeric password restriction:** Tests that the password that the user inputs will only be accepted if it consists only of alphanumeric characters. It is labeled as _"alphanumeric passwords only"_.
- **User has to confirm via e-mail before logging in:** Two tests are focused on the fact that only confirmed users can log in and view the /home route. Those are labeled as _"user has to confirm via e-mail"_ and _"confirmed user can view home page"_. And since capturing the e-mail and confirming an user through code could be difficult, an already confirmed user is being generated through Rails fixtures.