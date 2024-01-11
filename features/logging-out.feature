Feature: logging out

    As either a donor or recipient user
    So that I can protect my information and prevent misuse of my credits
    I want to be able to log out of the service.

Scenario:
    Given that I am logged in
    When I am on the home page
    And I click on the "Logout" button
    Then I should be logged out succesfully