Feature: Hide irrelevant features from profile page

Scenario: Recipient profile doesn't have the option to donate credits

    Given there is an user with the email of "john@tamu.edu", uid of "11110000", and 9 credits in the external API
    Given I am on the login page
    And I am a "recipient" profile
    When I go to the profile page
    Then I should see "Request Credits"
    And I should not see "Transfer Credits"

Scenario: Donor profile doesn't have the option to receive credits

    Given there is an user with the email of "john@tamu.edu", uid of "11110000", and 9 credits in the external API
    Given I am on the login page
    And I am a "donor" profile
    When I go to the profile page
    Then I should see "Transfer Credits"
    And I should not see "Request Credits"