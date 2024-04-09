Feature: Admin page

    As someone with power on my campus
    I want to be able to view the admin dashboard
    So I can make any nessesary changes

Scenario: Admin can access the school's credit pool from landing page

    Given I am an admin user
    And I am on the profile page
    Then I should see a button to access the school's admin page

Scenario: Non-admin users should not be able to access the Admin Dashboard

    Given I am on the login page
    And I am logged in as a non-admin user
    When I go to the admin page
    I should be back on the profile page