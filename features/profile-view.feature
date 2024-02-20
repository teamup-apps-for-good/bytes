Feature: profile view

    As a student with excess credits,
    So that I can know how many credits I can afford to donate,
    I want to see my account credits.

    As a food-insecure student,
    So that I can eat,
    I want to see my account credits

Background: Users in database
    Given the following credit pools exist:
    |   credits   |   email_suffix   |   id_name   |   school_name   |
    |      0      |     tamu.edu     |     UIN     |      TAMU       |

Scenario: student logs in
    Given I am on the login page
    And I am logged in
    When I go to the profile page
    Then I should see my "Name"
    And I should see my "Email"
    And I should see my "UIN"
    And I should see my "Type"
    And I should see my "Credits"
    And I should see "Transfer Credits"

Scenario: student goes to transfer
    Given I am on the login page
    And I am logged in
    When I go to the profile page
    And I click the "Transfer Credits" link
    Then I should be on the Transfer page

Scenario: can see the correct logo
    Given I am on the login page
    And I am logged in
    When I go to the profile page
    Then I should see the school logo displayed