Feature: Accept Meeting

Scenario: Recipient accepts meeting
        Given I am on the login page
        And that I am logged in an account with 7 credits
        Given there is a meeting listed
        And I am on the meetings page
        When I press "Accept"
        Then I should see "Meeting accepted."
        And I should see the meeting in my meetings

Scenario: Donor cancels meeting
        Given I am on the login page
        And I am logged in
        Given I am on the new meeting page
        And I have successfully scheduled a meeting
        Given I am on the meetings page
        When I press the 'Cancel' button
        Then I should see "Meeting deleted successfully."

Scenario: Donor cancels accepted meeting
        Given I am on the login page
        And I am logged in
        Given I have an accepted meeting listed
        And I am on the meetings page
        When I press the 'Cancel' button
        Then I should see "Meeting cancelled."

Scenario: Donor cancels accepted recurring meeting
        Given I am on the login page
        And I am logged in
        Given I have an accepted recurring meeting listed
        And I am on the meetings page
        When I press the 'Cancel' button
        Then I should see "Meeting cancelled. Recurring meeting posted."

Scenario: recipient cancels meeting
        Given I am on the login page
        And that I am logged in an account with 7 credits
        Given I as a recipient have an accepted meeting listed
        And I am on the meetings page
        When I press "Cancel"
        Then I should see "Meeting unaccepted."
        And I should see the meeting listed publicly