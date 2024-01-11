Feature: receive meal credits 

  As a student in need of credits
  So that I can get aid in getting food
  I want a way to request credits

Background: User and credits in database

  Given the following users exist:
  | uin      | name         | email            | credits | user_type | date_joined |
  | 11112222 | Sponge Bob   | sponge@tamu.edu  | 60      | donor     |  1977-05-26 |
  | 22223333 | Squid Ward   | patrick@tamu.edu | 50      | donor     |  1978-02-14 |
  | 33334444 | Patrick Star | squid@tamu.edu   | 5       | recipient |  1979-08-02 |
  | 44445555 | Eugene Krabs | krabs@tamu.edu   | 10      | recipient |  1967-11-31 |

  Given the following credit pools exist:
  |   credits   |
  |   20        |

Scenario: requesting for credits when there are some available
  Given I am a "recipient" account with uin "44445555"
  When  I go to the "receive" page
  And   I fill in "Number of Credits" with 10
  And   I press the "Get Credits" button
  Then  I should be on the profile page
  And   I should see "10 Credits received"
  And   I should have 20 credits

Scenario: requesting more credits then there are available
  Given I am a "recipient" account with uin "44445555"
  When  I go to the "receive" page
  And   the number of available credits is 5
  And   I currently have 10 credits
  When  I fill in "Number of Credits" with 10
  And   I press the "Get Credits" button
  Then  I should see "Error not enough credits available"
  And   I should have 10 credits
