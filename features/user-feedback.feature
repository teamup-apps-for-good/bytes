Feature: User Feedback

    As a user of Bytes
    I want to be able to send feedback to the Bytes team
    So I can voice any concerns I have about the app

Scenario: I can see the submit feedback button

    Given I am on the login page
    And I am logged in
    When I go to the profile page
    Then I should see "Give Feedback"

Scenario: I can access the user feedback page

    Given I am on the login page
    And I am logged in
    When I go to the profile page
    When I press the 'Give Feedback' button
    Then I should be on the user-feedback page

Scenario: I can submit user feedback

    Given I am on the login page
    And I am logged in
    When I press the 'Give Feedback' button
    And I fill in "feedback" with "this is my feedback"
    When I press the 'Submit Feedback' button
    Then I should see "Feedback sent!"
    

