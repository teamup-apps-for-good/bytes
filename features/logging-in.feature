Feature: logging in

    As a student
    In order to get access to my account
    I want the ability to sign into Bytes using my verified school email address


Background: Users in database

    Given the following users exist:
    |   name   |   uin   |    email     |  user_type   |
    |   John   | 123456  |  j@tamu.edu  |    donor     |

Scenario: user logs in with TAMU email
    Given I am a user with the email of "j@tamu.edu"
    Given there is an user with the email of "j@tamu.edu", uin of "123456", and 10 credits in the external API
    And I am on the login page
    And I click on the "Login with Google" button
    Then I should be logged in successfully

Scenario: user logs in with non-TAMU email
    Given I am a user with the email of "j@tam.edu"
    And I am on the login page
    And I click on the "Login with Google" button
    Then I should not be logged in