Feature: Metrics on Home Page

    As a student about to sign up for Bytes
    I want to see encouraging statistics on the home page
    So that I am more likely to see my potential impact and sign up for Bytes

Background: Users in database

    Given the following credit pools exist:
    |   credits   |
    |   50   |

Scenario: Happy path on home page

    Given I am not logged in
    And I am on the home page
    Then I should see a valid metric displayed on screen