Feature: Hide irrelevant features from profile page

Scenario: Recipient profile doesn't have the option to donate credits

    Given I am on the login page
    And I am a "recipient" profile
    When I go to the profile page
    Then I should see "Go to Receive"
    And I should not see "Go to Transfer"

Scenario: Donor profile doesn't have the option to receive credits

    Given I am on the login page
    And I am a "donor" profile
    When I go to the profile page
    Then I should see "Go to Transfer"
    And I should not see "Go to Receive"