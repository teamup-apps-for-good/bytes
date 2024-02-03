

Feature: Hide irrelevant features from profile page

    As a food insecure student,
    I want the option to donate credits to be hidden from my view,
    because I won’t be able to donate due to my lack of credits.

    As a student with excess credits,
    I want the option to receive credits to be hidden from my view,
    so that I cannot misuse the website's functionality.

Background: Users in database

    Given the following users exist:
    |   name   |   uin   |    email     |  user_type   |
    |   John   | 123456  |  j@tamu.edu  |    donor     |
    |   Todd   | 123456789  |  no-credits@tamu.edu  |   recipient  |
    |   Jim    | 124124  |  ai@tamu.edu |    donor     |

Scenario: Recipient profile doesn't have the option to donate credits

    
    Given there is an user with the email of "no-credits@tamu.edu", uin of "123456789", and 10 credits in the external API
    Given I am already logged in as an user with the email of "no-credits@tamu.edu "
    And I am a "recipient" profile
    When I go to the profile page
    Then I should see "Go to Receive"
    And I should not see "Go to Transfer"

Scenario: Donor profile doesn't have the option to receive credits

    Given there is an user with the email of "j@tamu.edu", uin of "123456", and 10 credits in the external API
    Given I am already logged in as an user with the email of "j@tamu.edu"
    And I am a "donor" profile
    When I go to the profile page
    Then I should see "Go to Transfer"
    And I should not see "Go to Receive"