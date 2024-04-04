Feature: User Feedback

    As a user of Bytes
    I want to be able to send feedback to the Bytes team
    So I can voice any concerns I have about the app

Scenario: I can see the submit feedback button

    Given I am on the login page
    And I am logged in
    When I go to the profile page
    Then I should see a button to submit user feedback

Scenario: I can access the user feedback page

    Given I am on the login page
    And I am logged in
    When I go to the profile page
    And I click the user-feedback button
    Then I should be on the user-feedback page

Scenario: I can submit user feedback

    Given I am on the user-feedback page
    And I have entered feedback comments
    And I press send
    Then it should send successfully
    

