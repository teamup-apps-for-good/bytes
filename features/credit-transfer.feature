Feature: Credit transfer

    As a student with excess credits,
    So that I can feed hungry students,
    I want to transfer some of my credits to another student.

Background: Users in database

    Given the following users exist:
    |   name   |   uid   |    email     |  user_type   |
    |   John   | 123456  |  j@tamu.edu  |    donor     |
    |   Todd   | 324567  |  t@tamu.edu  |   recipient  |
    |   Jim    | 124124  |  ji@tamu.edu |    donor     |

    Given the following credit pools exist:
    |   credits   |   email_suffix   |   id_name   |   school_name   |
    |      0      |     tamu.edu     |     UIN     |      TAMU       |
    

Scenario: donor student sends credits to pool
    Given there is an user with the email of "j@tamu.edu", uid of "123456", and 10 credits in the external API
    Given I am already logged in as an user with the email of "j@tamu.edu"
    Given API allows for -1 credit update for user with uid of "123456"
    When I go to the "transfer" page
    And I fill out "credit-amount" with "1"
    And I press the "credit-submission" button
    Then I should see "CONFIRMATION Sucessfully donated 1 credits to the pool!"

Scenario: donor student tries to send 0 credits to pool
    Given there is an user with the email of "j@tamu.edu", uid of "123456", and 10 credits in the external API
    Given I am already logged in as an user with the email of "j@tamu.edu"
    When I go to the "transfer" page
    And I fill out "credit-amount" with "0"
    And I press the "credit-submission" button
    Then I should see "ERROR Invalid input!"

Scenario: donor student tries to send more credits then they have
    Given there is an user with the email of "j@tamu.edu", uid of "123456", and 10 credits in the external API
    Given I am already logged in as an user with the email of "j@tamu.edu"
    When I go to the "transfer" page
    And I fill out "credit-amount" with "11"
    And I press the "credit-submission" button
    Then I should see "ERROR Trying to donate more credits than you have!"

