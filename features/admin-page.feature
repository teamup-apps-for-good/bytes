Feature: Admin page

    As someone with power on my campus
    I want to be able to view the admin dashboard
    So I can make any nessesary changes

Scenario: Admin can access the school's credit pool from landing page

    Given I am an admin user
    And I am on the profile page
    Then I should see a button to access the school's admin page