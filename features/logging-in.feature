Feature: logging in

    As a student
    In order to get access to my account
    I want the ability to sign into Bytes using my verified school email address


Background: Users in database

    Given the following users exist:
    |   name   |   uid   |     email     |  user_type   |
    |   John   | 123456  |   j@tamu.edu  |    donor     |
    |   Bob    | 1234567 | b@example.edu |    donor     |
    
    Given the following credit pools exist:
    |   credits   |   email_suffix   |   id_name   |   school_name   |
    |      0      |     tamu.edu     |     UIN     |      TAMU       |
    |      0      |    exmaple.edu   |     EXP     |      EXP        |

Scenario: user logs in with TAMU email
    Given I am a user with the email of "j@tamu.edu"
    Given there is an user with the email of "j@tamu.edu", uid of "123456", and 10 credits in the external API
    And I am on the login page
    And I click on the "Login with Google" button
    Then I should be logged in successfully

Scenario: user logs in with edu email
    Given I am a user with the email of "b@example.edu"
    Given there is an user with the email of "b@example.edu", uid of "1234567", and 10 credits in the external API
    And I am on the login page
    And I click on the "Login with Google" button
    Then I should be logged in successfully

Scenario: user logs in with non-edu email
    Given I am a user with the email of "j@gmail.com"
    And I am on the login page
    And I click on the "Login with Google" button
    Then I should not be logged in