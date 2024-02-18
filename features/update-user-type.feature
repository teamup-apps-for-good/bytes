Feature: update user_type

    As a student with changing needs,
    I want a button that allows me to switch user type,
    So that I can switch between receiving and donating credits based on my circumstances.

Background:

    Given the following users exist:
        |   name   |   uid   |    email     |  user_type   |
        |   John   | 123456  |  j@tamu.edu  |    donor     |
        |   Todd   | 324567  |  t@tamu.edu  |   recipient  |
        |   Jim    | 124124  |  ji@tamu.edu |    donor     |

        Given the following credit pools exist:
        |   credits   |
        |   15   |

Scenario: donor student should see a "Change to Recipient" button on their profile page
    Given there is an user with the email of "j@tamu.edu", uid of "123456", and 5 credits in the external API
    Given I am already logged in as an user with the email of "j@tamu.edu"
    When I go to the profile page
    Then I should have a submit button with the text "Change to Recipient"
    And I should not have a submit button with the text "Change to Donor"

Scenario: recipient student should see a "Change to Donor" button on their profile page
    Given there is an user with the email of "t@tamu.edu", uid of "324567", and 8 credits in the external API
    Given I am already logged in as an user with the email of "t@tamu.edu"
    When I go to the profile page
    Then I should have a submit button with the text "Change to Donor"
    And I should not have a submit button with the text "Change to Recipient"

Scenario: donor student successfully updates account type to recipient
    Given there is an user with the email of "j@tamu.edu", uid of "123456", and 5 credits in the external API
    Given I am already logged in as an user with the email of "j@tamu.edu"
    When I go to the profile page
    And I press the "Change to Recipient" button
    Then I should see "Type successfully updated to recipient"
    And I should see "Type: recipient"
    And I should have a submit button with the text "Change to Donor"

Scenario: recipient student successfully updates account type to donor
    Given there is an user with the email of "t@tamu.edu", uid of "324567", and 8 credits in the external API
    Given I am already logged in as an user with the email of "t@tamu.edu"
    When I go to the profile page
    And I press the "Change to Donor" button
    Then I should see "Type successfully updated to donor"
    And I should see "Type: donor"
    And I should have a submit button with the text "Change to Recipient"

Scenario: donor students over the credit limit fails to update account type to recipient
    Given there is an user with the email of "j@tamu.edu", uid of "123456", and 50 credits in the external API
    Given I am already logged in as an user with the email of "j@tamu.edu"
    When I go to the profile page
    And I press the "Change to Recipient" button
    Then I should see "Too many credits to be a recipient"
    And I should see "Type: donor"
    And I should have a submit button with the text "Change to Recipient"