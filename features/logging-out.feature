Feature: logging out
    As either a donor or recipient user
    So that I can protect my information and prevent misuse of my credits
    I want to be able to log out of the service.

Background: Users in database

    Given the following users exist:
    |   name   |   uid   |    email     |  user_type   |
    |   John   | 123456  |  j@tamu.edu  |    donor     |

Scenario: user logs out successfully
    Given there is an user with the email of "j@tamu.edu", uid of "123456", and 10 credits in the external API
    Given I am already logged in as an user with the email of "j@tamu.edu"
    And I am on the profile page
    When the user presses "Log Out"
    Then I should be logged out successfully