Feature: see credits

    As a student with excess credits,
    So that I can know how many credits I can afford to donate,
    I want to see my account credits.

    As a food-insecure student,
    So that I can eat,
    I want to see my account credits

Background: Users in database

    Given the following users exist:
    |   name   |   uin   |    email     |   credits   |    type      |   date_joined   |
    |   John   | 123456  |  j@tamu.edu  |     50      |    donor     |    01/01/2022   |
    |   Todd   | 324567  |  t@tamu.edu  |     10      |   recipient  |    01/01/2022   |
    |   Jim    | 124124  |  ji@tamu.edu |     70      |    donor     |    01/01/2022   |

Scenario: donor student goes to see credits
    Given I am a donor account
    When I go to the view credit page
    Then I should see my name
    And I should see my uin
    And I should see my accounnt type
    And I should see my credits

Scenario: recipient student goes to see credits
    Given I am a recipient account
    When I go to the view credit page
    Then I should see my name
    And I should see my uin
    And I should see my accounnt type
    And I should see my credits