Feature: donate and recieve

    As a food insecure student,
    I want the option to donate credits to be hidden from my view,
    because I won’t be able to donate due to my lack of credits.

    As a student with excess credits,
    I want the option to receive credits to be hidden from my view,
    so that I cannot misuse the website's functionality.

Scenario: Donate hidden from recipient
    Given I am signed into a recipient account
    When I am on the initial account page
    Then I should see a button for the recieve page
    And I should not see a button for the donate page

Scenario: Recieve hidden from donor
    Given I am signed into a donor account
    When I am on the initial account page
    Then I should see a button for the donate page
    And I should not see a button for the recieve page