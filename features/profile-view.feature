Feature: profile view

    As a student with excess credits,
    So that I can know how many credits I can afford to donate,
    I want to see my account credits.

    As a food-insecure student,
    So that I can eat,
    I want to see my account credits

Background: Users in database

Scenario: student logs in
    Given I am logged in
    And I am on the profile page
    Then I should see my "Name"
    And I should see my "Email"
    And I should see my "UIN"
    And I should see my "Type"
    And I should see my "Credits"

Scenario: student goes to transfer
    Given I am logged in
    When I press the "Go to Transfer" button
    Then I should be on the transfer page
