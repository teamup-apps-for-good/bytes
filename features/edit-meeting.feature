Feature: Edit Meeting

Scenario: Donor sees edit button for their meeting
    Given I am on the login page
    And I am logged in
    Given I am on the new meeting page
    And I have successfully scheduled a meeting
    Given I am on the meetings page
    Then I should see the 'Edit' button

Scenario: Edit page prefills meeting fields
    Given I am on the login page
    And I am logged in
    Given there is a meeting listed
    Given I am on the meetings page
    When I press the 'Edit' button
    Then I should see the fields are autofilled with my meeting's info

Scenario: Donor edits their meeting
    Given I am on the login page
    And I am logged in
    Given there is a meeting listed
    Given I am on the meetings page
    When I press the 'Edit' button
    And I edit a meeting's info
    Then I should see "Your meeting was successfully updated."
    And the meeting should have the updated information

Scenario: Donor cannot edit meeting that isn't theirs
    Given I am on the login page
    And I log in with a different uid
    Given there is a meeting listed
    Given I am on the meetings page
    Then I should not see the 'Edit' button