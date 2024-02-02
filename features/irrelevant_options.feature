Feature: Hide irrelevant features from profile page

    As a food insecure student,
    I want the option to donate credits to be hidden from my view,
    because I won’t be able to donate due to my lack of credits.

    As a student with excess credits,
    I want the option to receive credits to be hidden from my view,
    so that I cannot misuse the website's functionality.

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