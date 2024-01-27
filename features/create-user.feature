Feature: create user

    As a student
    In order to use the meal credit transfer feature
    I want the ability to create an account with Bytes using my verified school email address

    As a food insecure student,
    I want to meet the criteria for signing up to be a recipient,
    So that I can make sure that I am not misusing the website.

Scenario: new user logs in with TAMU email
    Given I am a new user with a TAMU email
    And I am on the login page
    And I click on the "Login with Google" button
    Then I should be on the create new user page
    And I should see a field for 'uin'
    And I should see a field for 'user type'

Scenario: new donor creates account
    Given I am a new user with a TAMU email
    And I am on the create new user page
    And I fill in uin with 111111111
    And I fill in user type donor
    Then an API call should be made to tamu-dining to get the user's credits
    And I should be logged in successfully

Scenario: new recipient creates account with 10 or less credits
    Given I am a new user with a TAMU email
    And I am on the create new user page
    And I fill in uin with 111111111
    And I fill in user type recipient
    Then an API call should be made to tamu-dining to get the user's credits
    And I should be logged in successfully

Scenario: new recipient creates account with more than 10 credits
    Given I am a new user with a TAMU email
    And I am on the create new user page
    And I fill in uin with 111111111
    And I fill in user type recipient
    Then an API call should be made to tamu-dining to get the user's credits
    And I should see the alert "Cannot be recipient, excess funds"
    And I should be on the bytes landing page
    And I should be logged out

