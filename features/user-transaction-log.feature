Feature: User Transaction Log

  As a donor student with excess credits,
  in order to know if my credits have been received and used,
  I want a page to look at data about my credit donations.

Background: Transactions in database

  Given the following transactions exist:
  |    uin    | transaction_type |         time         |   amount   |
  | 254007932 |    donated       | 2024-01-09T00:52:48  |      3     |
  | 214003865 |    donated       | 2023-11-19T00:52:48  |      1     |
  | 284007821 |    received      | 2024-01-01T00:52:48  |      2     |

Scenario: Donor account can see their donations
  Given I am logged in as a donor
  And I have made a donation
  When I go to the "My transactions" page
  Then I should see my donations

Scenario: Recipient account can see their received donations
  Given I am logged in as a recipient
  And I have received a donation
  When I go to the 'My transactions' page
  Then I should see my received donations
