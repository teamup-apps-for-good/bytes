Feature: profile view

    As a student with excess credits,
    So that I can know how many credits I can afford to donate,
    I want to see my account credits.

    As a food-insecure student,
    So that I can eat,
    I want to see my account credits

Background: Users in database

    Given the following users exist:
    |   name   |   uin   |    email     |   credits   |    user_type      |   date_joined   |
    |   John   | 123456  |  j@tamu.edu  |     50      |    donor     |    01/01/2022   |
    |   Todd   | 324567  |  t@tamu.edu  |     10      |   recipient  |    01/01/2022   |
    |   Jim    | 124124  |  ji@tamu.edu |     70      |    donor     |    01/01/2022   |

Scenario: student logs in
    Given I am a donor account
    When I log in
    Then I should be on the profile page
    And I should see my name
    And I should see my email
    And I should see my uin
    And I should see my account type
    And I should see my credits

Scenario: student goes to transfer
    Given I am a donor account
    When I log in
    And I click Go to transfer
    Then I should be on the transfer page
