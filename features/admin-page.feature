Feature: Admin page

    As someone with power on my campus
    I want to be able to view the admin dashboard
    So I can make any nessesary changes

Background:
    Given the following users exist:
    |   name   |   uid   |    email     |  admin   |
    |   John   | 123456  |  j@tamu.edu  |  true    |
        
    Given the following credit pools exist:
    |   credits   |   email_suffix   |   id_name   |   school_name   |
    |      50     |     tamu.edu     |     UIN     |      TAMU       |

Scenario: Admin can access the school's credit pool from landing page

    Given I am on the login page
    And I am logged in as an admin
    When I visit the admin page
    And I press "View Credit Pool"
    Then I should be on my school's credit pool page
