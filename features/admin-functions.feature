Feature: Admin functions

    As someone with power on my campus
    I want to be able to view and edit my schools credit pool
    So I can make nessesary changes and view the health of my schools pool

Scenario: Admin can manually add credits to the school's credit pool

    Given I am an admin user
    And I am on the admin page
    And I enter "10" credits in the enter-credits field
    And I press submit
    Then the school's credit pool should have "10" more credits added

Scenario: Admin can manually remove credits from the school's credit pool

    Given I am an admin user
    And I am on the admin page
    And I enter "-10" credits in the enter-credits field
    And I press submit
    Then the school's credit pool should have "10" less credits added

Scenario: Admin can view users of a school

    Given I am an admin user
    And I am on the admin page
    Then I can see a list of my school's users

