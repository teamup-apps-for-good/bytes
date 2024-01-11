Feature: logging out

    As either a donor or recipient user
    So that I can protect my information and prevent misuse of my credits
    I want to be able to log out of the service.

Scenario: user logs out successfully
    Given I am a user with a TAMU email
    When I am on the login page
    And I click on the "Login with Google" button
    When the user fills in "123456" for "uin"
    And the user fills in "10" for "credits"
    And the user presses "Save Changes"
    And I click on the "Logout" button
    Then I should be logged out succesfully