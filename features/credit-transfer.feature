Feature: Credit transfer

    As a student with excess credits,
    So that I can feed hungry students,
    I want to transfer some of my credits to another student.

Background: Users in database

    Given the following users exist:
    |   name   |   uin   |    email     |   credits   |    type      |   date_joined   |
    |   John   | 123456  |  j@tamu.edu  |     50      |    donor     |    01/01/2022   |
    |   Todd   | 324567  |  t@tamu.edu  |     10      |   recipient  |    01/01/2022   |
    |   Jim    | 124124  |  ji@tamu.edu |     70      |    donor     |    01/01/2022   |

Scenario: donor student sends credits to pool
    Given I am a donor account
    When I go to the credit transfer page
    And I fill out 1 credit to transfer
    And I press the submit button
    Then I should see a confirmation popup
    And I should see 1 credit removed from my account

Scenario: donor student tries to send 0 credits to pool
    Given I am a donor account
    When I go to the credit transfer page
    And I fill out 0 credits to transfer
    And I press the submit button
    Then I should see an error popup
    And I should see 0 credits removed from my account

Scenario: donor student tries to send more credits then they have
    Given I am a donor account John
    When I go to the credit transfer page
    And I fill out 51 credits to transfer
    And I press the submit button
    Then I should see an error popup
    And I should see 0 credits removed from my account
