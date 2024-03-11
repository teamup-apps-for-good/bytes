Feature: Meeting Creation

Scenario: User creates a meeting
    Given I am on the login page
    And I am logged in
    Given I am on the new meeting page
    When I fill in the meeting form with valid details
    And I press "Schedule Meeting"
    Then I should see "Meeting scheduled successfully."
    And I should see the new meeting in the meetings list

Scenario: User creates a meeting without date
    Given I am on the login page
    And I am logged in
    Given I am on the new meeting page
    When I fill in the meeting form without date
    And I press "Schedule Meeting"
    Then I should see "Schedule a Meeting"

Scenario: User creates a meeting without time
    Given I am on the login page
    And I am logged in
    Given I am on the new meeting page
    When I fill in the meeting form without time
    And I press "Schedule Meeting"
    Then I should see "Schedule a Meeting"

Scenario: User creates a meeting without location
    Given I am on the login page
    And I am logged in
    Given I am on the new meeting page
    When I fill in the meeting form without location
    And I press "Schedule Meeting"
    Then I should see "Schedule a Meeting"

Scenario: User does not create a meeting
    Given I am on the login page
    And I am logged in
    Given I am on the new meeting page
    When I fill in the meeting form with valid details
    Then I should not see the meeting in the meetings list