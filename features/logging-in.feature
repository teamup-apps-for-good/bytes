Feature: logging in

    As a student
    In order to get access to my account
    I want the ability to sign into Bytes using my verified school email address

Scenario: user logs in with TAMU email
    Given I am a user with a TAMU email
    And I am on the login page
    And I click on the "Login with Google" button
    Then I should be logged in successfully

Scenario: user logs in with non TAMU email
    Given I am a user with a non TAMU email
    And I am on the login page
    And I click on the "Login with Google" button
    Then I should be not logged in