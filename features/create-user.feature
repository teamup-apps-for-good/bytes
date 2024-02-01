Feature: create user

    As a student
    In order to use the meal credit transfer feature
    I want the ability to create an account with Bytes using my verified school email address

    As a food insecure student,
    I want to meet the criteria for signing up to be a recipient,
    So that I can make sure that I am not misusing the website.


Background: Users in database

    Given the following users exist:
    |   name   |   uin   |    email     |  user_type   |

Scenario: new user logs in with TAMU email
    Given there is an user with the email of "new@tamu.edu", uin of "123456", and 10 credits in the external API
    Given I am a user with the email of "new@tamu.edu"
    And I am on the login page
    And I click on the "Login with Google" button
    Then I should be on the create new user page
    And I should see a field for 'UIN'
    And I should see a field for 'User Type'

Scenario: new donor creates account
    Given there is an user with the email of "new@tamu.edu", uin of "123456", and 10 credits in the external API
    Given I am a user with the email of "new@tamu.edu"
    And I am on the login page
    And I click on the "Login with Google" button
    Then I should be on the create new user page
    And I fill in "UIN" with "123456"
    And I select "donor" from "User Type"
    Then I press the "Create Account" button
    Then I should be logged in successfully

Scenario: new recipient creates account with 10 or less credits
    Given there is an user with the email of "new@tamu.edu", uin of "123456", and 10 credits in the external API
    Given I am a user with the email of "new@tamu.edu"
    And I am on the login page
    And I click on the "Login with Google" button
    Then I should be on the create new user page
    And I fill in "UIN" with "123456"
    And I select "recipient" from "User Type"
    Then I press the "Create Account" button
    Then I should be logged in successfully

Scenario: new recipient creates account with more than 10 credits
    Given there is an user with the email of "new@tamu.edu", uin of "123456", and 11 credits in the external API
    Given I am a user with the email of "new@tamu.edu"
    And I am on the login page
    And I click on the "Login with Google" button
    Then I should be on the create new user page
    And I fill in "UIN" with "123456"
    And I select "recipient" from "User Type"
    Then I press the "Create Account" button
    Then I should failed to log in with "User has too many credits to create a receipent account"