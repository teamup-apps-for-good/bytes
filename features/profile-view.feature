Feature: profile view

    As a student with excess credits,
    So that I can know how many credits I can afford to donate,
    I want to see my account credits.

    As a food-insecure student,
    So that I can eat,
    I want to see my account credits

Background: Users in database
    Given the following credit pools exist:
    |   credits   |
    |   0   |

Scenario: student logs in
    Given I am on the login page
    And I am logged in
    When I go to the profile page
    Then I should see my "Name"
    And I should see my "Email"
    And I should see my "UIN"
    And I should see my "Type"
    And I should see my "Credits"
    And I should see "Go to Transfer"

Scenario: student goes to transfer
    Given I am on the login page
    And I am logged in
    When I go to the profile page
    And I click the "Go to Transfer" link
    Then I should be on the Transfer page