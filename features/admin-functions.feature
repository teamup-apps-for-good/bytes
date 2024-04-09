Feature: Admin functions

    As someone with power on my campus
    I want to be able to view and edit my schools credit pool
    So I can make nessesary changes and view the health of my schools pool

Background:
    Given the following users exist:
    |   name   |   uid   |    email     |  admin   |
    |   John   | 123456  |  j@tamu.edu  |  true    |
        
    Given the following credit pools exist:
    |   credits   |   email_suffix   |   id_name   |   school_name   |
    |      50     |     tamu.edu     |     UIN     |      TAMU       |

Scenario: Admin can manually add credits to the school's credit pool

    Given I am on the login page
    And I am logged in as an admin
    When I visit the admin page
    Then I should see "Admin Dashboard"
    And I enter "10" credits in the update-credits field
    And I press "Add Credits"
    Then the school should have 60 credits in the pool
    And I should see "Successfully added 10 credits to the pool!"

Scenario: Admin can manually remove credits from the school's credit pool

    Given I am on the login page
    And I am logged in as an admin
    When I visit the admin page
    And I enter "10" credits in the update-credits field
    And I press "Subtract Credits"
    Then the school should have 40 credits in the pool
    And I should see "Successfully subtracted 10 credits from the pool"

Scenario: Admin tries to remove more credits than there are available in the pool

    Given I am on the login page
    And I am logged in as an admin
    When I visit the admin page
    And I enter "80" credits in the update-credits field
    And I press "Subtract Credits"
    Then the school should have 50 credits in the pool
    And I should see "Can't subtract more credits than there are available, only 50 credits currently in pool"

