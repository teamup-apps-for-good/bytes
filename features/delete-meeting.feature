Feature: Meeting Creation

Scenario: User deletes a meeting
    Given I am on the login page
    And I am logged in
    Given I am on the new meeting page
    And I have successfully scheduled a meeting
    Given I am on the meetings page
    When I press the 'Cancel' button
    Then I should see "Meeting deleted successfully."


