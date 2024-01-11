Feature: Credit transfer

    As a student with excess credits,
    So that I can feed hungry students,
    I want to transfer some of my credits to another student.

Background: Users in database

    Given the following users exist:
    |   name   |   uin   |    email     |   credits   |  user_type   |   date_joined   |
    |   John   | 897324  |  j@tamu.edu  |     50      |    donor     |    01/01/2022   |
    |   Todd   | 324567  |  t@tamu.edu  |     10      |   recipient  |    01/01/2022   |
    |   Jim    | 124124  |  ji@tamu.edu |     70      |    donor     |    01/01/2022   |

    Given the following credit pools exist:
    |   credits   |
    |   0   |
    

Scenario: donor student sends credits to pool
    Given I am a "donor" account with uin "12345"
    When I go to the transfer page
    And I fill out "credit-amount" with "1" credit to transfer
    And I press the "credit-submission" button
    Then I should see a "CONFIRMATION" popup
    And I should see "1" credit removed from my account

Scenario: donor student tries to send 0 credits to pool
    Given I am a "donor" account with uin "12345"
    When I go to the transfer page
    And I fill out "credit-amount" with "0" credit to transfer
    And I press the "credit-submission" button
    Then I should see a "ERROR" popup
    And I should see "0" credits removed from my account

Scenario: donor student tries to send more credits then they have
    Given I am a "donor" account with uin "12345"
    When I go to the transfer page
    And I fill out "credit-amount" with "51" credit to transfer
    And I press the "credit-submission" button
    Then I should see a "ERROR" popup
    And I should see "0" credits removed from my account

