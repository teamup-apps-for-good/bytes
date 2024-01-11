Feature: logging in

    As a student
    In order to get access to my account
    I want the ability to sign into Bytes using my verified school email address

Scenario: user logs in with TAMU email
    Given I am on the login page
    When I click on the "Sign in with Google" button
    And I log in with a tamu.edu email
    Then I should be logged in successfully